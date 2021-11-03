#!/usr/bin/env bash
set -e

rg --type md --word-regexp --file textgift.txt --sort path --stats
