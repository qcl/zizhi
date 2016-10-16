#!/usr/bin/python
# -*- coding: utf-8 -*-
# parser.py

import re
import os
import json
import argparse

import zizhi

# TODO: need be able to be extended
zizhi_actions = zizhi.actions

# TODO: consider multiple platforms
# TODO: need be able to be extended
zizhi_element_types = zizhi.elementTypes 

# TODO: need be able to be extended
zizhi_preps = [
            "in",
            "on"
        ]

# Step tokens
#   Action
#       tap, type, verify...etc.
#   Identifier
#       **identifier**
#   Type
#       button, link...etc.
#   String
#       "this is a string"
#   Prep
#       in, on...etc

def tokenize_step(content):
    identifier_regex = r"\*{2}(?P<identifier>[\W\d ]+|[\w\d ]+)\*{2}"
    string_regex = r"\"(?P<string>.*)\""

    strings = []
    identifiers = []
    types = []
    preps = []

    # replace string first.
    string_matches = re.finditer(string_regex, content)
    for matchNum, match in enumerate(string_matches):
        strings.append(match.group("string"))
    if len(strings) > 0:
        content = re.sub(string_regex, " __str__ ", content, 0)

    # handle identifier
    identifier_matches = re.finditer(identifier_regex, content)
    for matchNum, match in enumerate(identifier_matches):
        identifiers.append(match.group("identifier"))
    if len(identifiers) > 0:
        content = re.sub(identifier_regex, " __identifier__ ", content, 0)

    content = content.lower()

    # FIXME & TODO initialize it only once
    element_type_state = {}
    for element_type in zizhi_element_types:
        current_state = element_type_state
        element_type_words = element_type.split()
        for element_type_word in element_type_words:
            if not element_type_word in current_state:
                current_state[element_type_word] = {}
            current_state = current_state[element_type_word]
        if not "__type__" in current_state:
            current_state["__type__"] = element_type
        else:
            print "Shouldn't print this line"

    tokens = []

    content = content.replace("."," ").replace(","," ")
    content_words = content.split()
    content_words.append("__eol__") # FIXME: work around for handling last word

    current_state = element_type_state
    possible_type = None

    for word in content_words:
        if word not in current_state and possible_type is not None:
            token = {
                        "type": "type",
                        "content": possible_type
                    }
            tokens.append(token)
            possible_type = None
            current_state = element_type_state
        elif word in element_type_state:
            current_state = element_type_state

        if word in zizhi_actions:
            token = {
                        "type": "action",
                        "content": word
                    }
            tokens.append(token)
            continue

        elif word in zizhi_preps:
            token = {
                        "type": "prep",
                        "content": word
                    }
            tokens.append(token)
            continue

        elif word == "__str__":
            token = {
                        "type": "string",
                        "content": strings.pop(0)
                    }
            tokens.append(token)
            continue

        elif word == "__identifier__":
            token = {
                        "type": "identifier",
                        "content": identifiers.pop(0)
                    }
            tokens.append(token)
            continue

        elif word in current_state:
            current_state = current_state[word]
            if "__type__" in current_state:
                possible_type = current_state["__type__"]
        else:
            current_state = element_type_state

    if len(tokens) > 0:
        return tokens

# Line types
#   Title
#       Start with # or ##, # means it is title for test case, ## is for section.
#   Description
#       Description for test case or section.
#   Step
#       Start with num. , it describes behavior

# NOTE: syntax now let line is independent with each other line
def tokenize_line(line, line_number = None):
    # line_number will be use to show debug message, if I have time to do that.
    #print line_number, line
    line = line.strip()

    if len(line) == 0:
        return

    step_regex = r"^(?P<step>\d+)\.\s(?P<content>.*)"
    step_matches = re.findall(step_regex, line)

    if line[0:2] == "# ":                   # Level 1 title
        title = line[1:].strip()
        token = {
                    "type": "title",
                    "level": 1,
                    "content": title
                }
        return token

    elif line[0:2] == "##":                 # Level 2 title # NOTE: I think # and ## is also title
        title = line[2:].strip()
        token = {
                    "type": "title",
                    "level": 2,
                    "content": title
                }
        return token

    elif len(step_matches) > 0:             # Step
        first_match = step_matches[0]
        token = {
                    "type": "step",
                    "step": int(first_match[0]),
                    "content": first_match[1]
                }
        return token

    elif len(line) > 0:                     # Description
        token = {
                    "type": "description",
                    "content": line
                }
        return token

    else:
        # nothing
        pass


def parse_testcase_file(filepath):
    print 'Parse',filepath
    dirname, filename = os.path.split(filepath)
    print dirname,filename

    testcase_file = open(os.path.join(dirname, filename), 'r')

    line_results = []

    # read file line by line
    line_number = 0
    for line in testcase_file:
        line_number += 1
        line_result = tokenize_line(line, line_number)
        if line_result:
            line_results.append(line_result)

        #print line_number, line_result
    testcase_file.close()
    #print line_results

    ### Build Parsed Result ###

    testcase = {    # TODO: change default values
                "title": filename,
                "description": "",
                "sections": []
            }

    current_section = {
                "title": None,
                "description": "",
                "actions": []
            }

    for line_result in line_results:
        line_type = line_result["type"]
        if line_type == "title":
            if line_result["level"] == 1:
                testcase["title"] = line_result["content"]
            else:
                # already had another section, here need to start a new one
                if current_section["title"]:
                    # save previous one into sections of testcase
                    testcase["sections"].append(current_section)
                    # create a new one then assing title to it.
                    current_section = {
                                "title": line_result["content"],
                                "description": "",
                                "actions": []
                            }

                # here appears the first section
                else:
                    current_section["title"] = line_result["content"]

        elif line_type == "description":
            # in a section
            if current_section["title"]:
                current_section["description"] += "%s\n" % (line_result["content"])

            # there is no section
            else:
                testcase["description"] += "%s\n" % (line_result["content"])

        elif line_type == "step":
            #print line_result["content"]
            step_tokens = tokenize_step(line_result["content"])
            action = {
                        "action": None,
                        "string": None,
                        "matcher": None
                    }
            matcher = {
                        "type": None,
                        "identifier": None,
                        "parent": None
                    }
            action["matcher"] = matcher

            for token in step_tokens:
                token_type = token["type"]
                token_content = token["content"]

                if token_type == "action":
                    if action["action"] is None:
                        action["action"] = token_content
                    else:
                        # TODO: handle error
                        pass

                elif token_type == "string":
                    if action["string"] is None:
                        action["string"] = token_content
                    else:
                        # TODO: handle error
                        pass

                elif token_type == "prep":
                    # need a new matcher
                    if matcher["parent"] is None:
                        previous_matcher = matcher
                        matcher = {
                                    "type": None,
                                    "identifier": None,
                                    "parent": None
                                }
                        previous_matcher["parent"] = matcher
                    else:
                        # TODO: handle error
                        pass

                elif token_type == "type":
                    if matcher["type"] is None:
                        matcher["type"] = token_content
                    else:
                        # TODO: handle error
                        pass

                elif token_type == "identifier":
                    if matcher["identifier"] is None:
                        matcher["identifier"] = token_content
                    else:
                        # TODO: handle error
                        pass

            # verify action
            verified = False
            if action["action"] is not None and action["matcher"] is not None:
                matcher = action["matcher"]
                if matcher["type"] is not None or matcher["identifier"] is not None:
                    verified = True
                elif action["string"] is not None:
                    verified = True
                    action["matcher"] = None

            #print verified
            # TODO: fix some possible error
            if verified and action["matcher"] is not None:
                #print action["matcher"]
                matcher = action["matcher"]
                parent_matcher = matcher["parent"]
                while parent_matcher is not None:
                    if parent_matcher["type"] is not None or parent_matcher["identifier"] is not None:
                        matcher = parent_matcher;
                        parent_matcher = matcher["parent"]
                    else:
                        matcher["parent"] = parent_matcher["parent"]
                        parent_matcher = matcher["parent"]
                #print action["matcher"]

            #print action
            if verified:
                current_section["actions"].append(action)

    # verify latest section
    if current_section["title"] is not None:
        testcase["sections"].append(current_section)

    # TODO: move write file part out of this method
    print testcase

    filename_without_ext, ext = os.path.splitext(filename)
    middle_format_filename = "%s.zz" % (filename_without_ext)
    middle_format_filepath = os.path.join(dirname, middle_format_filename)

    print "wirte to", middle_format_filepath
    output = open(middle_format_filepath, "w")
    json.dump(testcase, output)
    output.close()

if __name__ == '__main__':
    argp = argparse.ArgumentParser(description='Zizhi\'s parser')
    argp.add_argument('filename', metavar = 'f', type=str, help='Testcase filename')
    args = argp.parse_args()

    parse_testcase_file(args.filename)

