#!/usr/bin/env bash
set -e

rm -rf public
hugo
rsync -acv --compress --omit-dir-times --exclude=.DS_Store --delete-delay public/ www.edjopato.de:/var/www/edjopato.de/ \
    | grep -v '/page/' \
    | grep -v '^tags/' \
    | grep -v '^categories/'
