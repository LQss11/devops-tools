#!/bin/bash
##
# This script print a directory tree of a project
##
find . -print | sed -e 's;[^/]*/;|--;g;s;--|;  |;g