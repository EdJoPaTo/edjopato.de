#!/usr/bin/env bash
set -e

rm -rf public
hugo
rsync -acv --compress --omit-dir-times --delete-delay --delay-updates \
	--exclude=.DS_Store \
	public/ www.edjopato.de:/var/www/edjopato.de/ \
	| grep -v '/page/' \
	| grep -v '^tags/' \
	| grep -v '^categories/'
