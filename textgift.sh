#!/usr/bin/env bash
set -e

rg --type md --word-regexp --ignore-case --file textgift.txt --sort path --stats
