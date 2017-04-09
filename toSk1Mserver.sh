#!/bin/bash
bundle exec jekyll build
rsync -acv --delete-delay _site/ sk1m.de:/usr/share/nginx/de.edjopato/
