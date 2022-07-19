#!/usr/bin/env bash
set -e

rm -rf public
hugo
rsync \
	--recursive --perms --times --omit-dir-times \
	--compress --verbose --checksum --delete-delay --delay-updates \
	--exclude=.DS_Store \
	public/ www.edjopato.de:/var/www/edjopato.de/ \
	| grep -v '/page/' \
	| grep -v '^tags/' \
	| grep -v '^categories/'
