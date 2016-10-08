#!/usr/bin/python
# -*- coding: utf-8 -*-
# parser.py

import re
import argparse

# NOTE: syntax now let line is independent with each other line
def tokenliz_line(line, line_number = None):
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


def parse_testcase_file(filename):
    print 'Parse',filename

    testcase_file = open(filename, 'r')

    parse_result = {
                "testcase_title": filename,
                "testcase_description": filename,
                "sections": []
            }

    line_number = 0
    for line in testcase_file:
        line_number += 1
        line_result = tokenliz_line(line, line_number)
        if line_result:
            print line_number, line_result

    testcase_file.close()

if __name__ == '__main__':
    argp = argparse.ArgumentParser(description='Zizhi\'s parser')
    argp.add_argument('filename', metavar = 'f', type=str, help='Testcase filename')
    args = argp.parse_args()

    parse_testcase_file(args.filename)

