#!/bin/bash
rm -rf public
hugo && rsync -acv --delete-delay public/ sk1m.de:/usr/share/nginx/de.edjopato/ | grep -E '^deleting|[^/]$|^$'
