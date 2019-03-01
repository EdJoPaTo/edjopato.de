#!/bin/bash
rm -rf public
hugo && rsync -acv --exclude=.DS_Store --delete-delay public/ sk1m.de:/usr/share/nginx/de.edjopato/ | grep -E '^deleting|[^/]$|^$'
