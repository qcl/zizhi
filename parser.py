#!/usr/bin/python
# -*- coding: utf-8 -*-
# parser.py

import argparse

def parse_testcase_file(filename):
    print filename

if __name__ == '__main__':
    argp = argparse.ArgumentParser(description='Zizhi\'s parser')
    argp.add_argument('filename', metavar = 'f', type=str, help='Testcase filename')
    args = argp.parse_args()

    parse_testcase_file(args.filename)

