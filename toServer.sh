#!/bin/bash
rm -rf public
hugo && rsync -acv --omit-dir-times --exclude=.DS_Store --delete-delay public/ www.edjopato.de:/var/www/edjopato.de/ | grep -E '^deleting|[^/]$|^$' | grep -v '/page/' | grep -v '^tags/' | grep -v '^categories/'
