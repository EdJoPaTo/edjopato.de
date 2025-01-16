#!/usr/bin/env bash
set -u

urls=$(grep "https://" static/tv.m3u)

for url in $urls; do
	echo "::group::$url"

	nice ffmpeg -y -v error -i "$url" -c copy -codec:v h264 -t 0:05 -f mp4 /dev/null

	echo "::endgroup::"
done
