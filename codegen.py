#!/usr/bin/python
# -*- coding: utf-8 -*-
# codegen.py

import json
import argparse

import zizhi

# read testcase object from .zz file.  
def read_testcase(testcase_filepath):
    f = open(testcase_filepath, 'r')
    testcase = json.load(f)
    f.close()
    return testcase

def get_variable_name_with_prefiex(prefix, variables):
    if prefix not in variables:
        variables[prefix] = 0
    variables[prefix] += 1
    return '%s_%d' % (prefix, variables[prefix])

def get_current_use_variable_name_with_prefix(prefix, variables):
    if prefix in variables:
        return '%s_%d' % (prefix, variables[prefix])
    return None

def gen_objc_testcode_type(zztype):
    if zztype in zizhi.elementType.objcMapping:
        return zizhi.elementType.objcMapping[zztype]
    return None

def gen_objc_testcode_matcher(matcher, variables):

    zzmatcher_prefix = 'zzm'
    lines = []

    def parent_matcher(matcher):
        parent_var_name = None
        if matcher["parent"]:
            parent_var_name = parent_matcher(matcher["parent"])
        #print matcher
        m_type = matcher["type"]
        m_id   = matcher["identifier"]

        generated_code = None
        var_name = None
        if m_type is not None and m_id is not None:
            type = gen_objc_testcode_type(m_type)
            if type is not None:
                allocate_code = '[[ZZMatcher alloc] initWithIdentifier:@"%s" elementType:%s];' % (m_id, type)
                var_name = get_variable_name_with_prefiex(zzmatcher_prefix, variables)
                generated_code = 'ZZMatcher *%s = %s' % (var_name, allocate_code)
                #print generated_code
        elif m_type is not None:
            type = gen_objc_testcode_type(m_type)
            if type is not None:
                allocate_code = '[[ZZMatcher alloc] initWithElementType:%s];' % (type)
                var_name = get_variable_name_with_prefiex(zzmatcher_prefix, variables)
                generated_code = 'ZZMatcher *%s = %s' % (var_name, allocate_code)
                #print generated_code
        elif m_id is not None:
            allocate_code = '[[ZZMatcher alloc] initWithIdentifier:@"%s"];' % (m_id)
            var_name = get_variable_name_with_prefiex(zzmatcher_prefix, variables)
            generated_code = 'ZZMatcher *%s = %s' % (var_name, allocate_code)
            #print generated_code
        else:
            pass

        if generated_code is not None and var_name is not None:
            lines.append(generated_code)
            if parent_var_name is not None:
                assign_parent_code = '%s.ancestor = %s;' % (var_name, parent_var_name)
                #print assign_parent_code
                lines.append(assign_parent_code)
            return var_name

        return None

    parent_matcher(matcher)

    if len(lines) > 0:
        current_matcher_var_name = get_current_use_variable_name_with_prefix(zzmatcher_prefix, variables)
        target_element_var_name = get_variable_name_with_prefiex('targetElement', variables)
        queyr_code = 'XCUIElement *%s = [Zizhi findElementByZizhiMatcher:%s];' % (target_element_var_name, current_matcher_var_name);
        lines.append(queyr_code)
        #print queyr_code
        #print lines
        return lines, target_element_var_name
    return [], None


def gen_objc_testcode_action_tap(action, variables):
    lines = []
    matcher = action["matcher"]
    if matcher is None:
        return [], None
    
    # match
    match_lines, var_name = gen_objc_testcode_matcher(matcher, variables)
    if len(match_lines) == 0:
        return [], None
    #print match_lines
    lines.extend(match_lines)

    # tap it
    tap_code = '[%s tap];' % (var_name)
    lines.append(tap_code)
    #print tap_code

    return lines, var_name

def gen_objc_testcode_action_type(action, variables):
    # TODO
    return [], None

def gen_objc_testcode_action_verify(action,variables):
    lines = []
    matcher = action["matcher"]
    if matcher is None:
        return [], None
    
    # match
    match_lines, var_name = gen_objc_testcode_matcher(matcher, variables)
    if len(match_lines) == 0:
        return [], None
    #print match_lines
    lines.extend(match_lines)

    # varify it.
    verify_code = 'XCTAssertNotNil(%s);' % (var_name)
    lines.append(verify_code)
    #print verify_code

    return lines, var_name

def gen_objc_testcode_action(action_object, variables):
    action_code = None
    var_name = None
    action = action_object["action"]
    if action == zizhi.action.Tap:
        action_code, var_name = gen_objc_testcode_action_tap(action_object, variables)
    elif action == zizhi.action.Type:
        action_code, var_name = gen_objc_testcode_action_type(action_object, variables)
    elif action == zizhi.action.Verify:
        action_code, var_name = gen_objc_testcode_action_verify(action_object, variables)

    if len(action_code) > 0:
        action_code.append('')
        return action_code, var_name
    return [], None

def gen_objc_testcode_section(section, variables):
    lines = []
    #print section["title"]
    lines.append('// %s' % (section['title']))
    for action in section["actions"]:
        action_code, var_name = gen_objc_testcode_action(action, variables)
        if len(action_code) > 0:
            lines.extend(action_code)
    return lines, None

def gen_objc_testcode(testcase):
    # FIXME - use context object or oo's property to share context information
    variables = {}
    lines = []
    testcode = ''
    for section in testcase["sections"]:
        section_code, var_name = gen_objc_testcode_section(section, variables)
        if len(section_code) > 0:
            lines.extend(section_code)
    #print lines
    return lines, None


def gen_objc_testmethod_name(testcase):
    title = testcase["title"].replace(' ', '_')
    method_name = 'test_%s' % (title)
    return method_name

def gen_objc_testmethod(testcase):
    template = '''
// {{testcase.title}}
- (void) {{test_method_name}} {
    {{testcodes}}
}
'''

    title = testcase["title"]
    test_method_name = gen_objc_testmethod_name(testcase)
    testcode, var_name = gen_objc_testcode(testcase)

    # method name
    template = template.replace('{{testcase.title}}', title)
    template = template.replace('{{test_method_name}}', test_method_name)

    # FIXME
    mutipleLine = '''{{a}}
    {{b}}'''

    template = template.replace('{{testcodes}}', mutipleLine)

    for line in testcode:
        template = template.replace('{{a}}', line).replace('{{b}}', mutipleLine)
    template = template.replace('{{a}}\n','').replace('{{b}}','')

    print template

def generate_testcase(testcase):
    gen_objc_testmethod(testcase)


def codegen(filepath):
    print "Gen code from", filepath

    # read a test case and generate code.
    testcase = read_testcase(filepath)
    generate_testcase(testcase)

if __name__ == '__main__':
    argp = argparse.ArgumentParser(description='Zizhi\'s code generater')
    argp.add_argument('filename', metavar = 'f', type=str, help='Zizhi format testcase filename')
    args = argp.parse_args()

    codegen(args.filename)
