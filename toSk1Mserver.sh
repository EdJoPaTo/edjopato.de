#!/bin/bash
bundle exec jekyll build
rsync -acv _site/ sk1m.de:/usr/share/nginx/de.edjopato/
