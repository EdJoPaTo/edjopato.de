#!/bin/bash
rm -rf public
hugo && rsync -acv --omit-dir-times --exclude=.DS_Store --delete-delay public/ www.3t0.de:/var/www/edjopato.de/ | grep -E '^deleting|[^/]$|^$' | grep -E '/page/'
