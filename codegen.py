#!/usr/bin/python
# -*- coding: utf-8 -*-
# codegen.py

import argparse

def codegen(filepath):
    print "Gen code from", filepath

if __name__ == '__main__':
    argp = argparse.ArgumentParser(description='Zizhi\'s code generater')
    argp.add_argument('filename', metavar = 'f', type=str, help='Zizhi format testcase filename')
    args = argp.parse_args()

    codegen(args.filename)
