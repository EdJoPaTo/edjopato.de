#!/usr/bin/env bash
# from https://edjopato.de/post/2022/11/09-avif-jpg-jxl-webp/
# adapted from https://github.com/EdJoPaTo/rain-brainz.de/blob/87da7766c998f1707066b689d24c406e1e3c1ae5/generate.sh#L30-L51

rm -rf output/*
mkdir -p output

for file in originals/*; do
	filename=$(basename "$file")
	basename="${filename%.*}"

	thumb="output/${basename}_thumb"
	big="output/${basename}_big"
	download="output/${basename}_download"

	nice convert "$file" -strip -resize '450x400>' -quality 85 "$thumb.avif" &
	nice convert "$file" -strip -resize '450x400>' -quality 85 -sampling-factor 4:2:0 "$thumb.jpg" &
	nice convert "$file" -strip -resize '450x400>' -quality 85 "$thumb.jxl" &
	nice convert "$file" -strip -resize '450x400>' -quality 85 "$thumb.webp" &
	wait
	nice convert "$file" -strip -resize '2000x2000>' -quality 85 "$big.avif" &
	nice convert "$file" -strip -resize '2000x2000>' -quality 85 -sampling-factor 4:2:0 "$big.jpg" &
	nice convert "$file" -strip -resize '2000x2000>' -quality 85 "$big.jxl" &
	nice convert "$file" -strip -resize '2000x2000>' -quality 85 "$big.webp" &
	wait
	nice convert "$file" -strip -quality 95 "$download.avif" &
	nice convert "$file" -strip -quality 95 -sampling-factor 4:2:0 "$download.jpg" &
	nice convert "$file" -strip -quality 95 "$download.jxl" &
	nice convert "$file" -strip -quality 95 "$download.webp" &
	wait
done

exa --no-time --no-user --no-permissions --long output/

for kind in thumb big download; do
	for filetype in avif jpg jxl webp; do
		du --total --human-readable output/*_$kind.$filetype | rg "total$" | sed "s/total/$kind.$filetype/g"
	done
done
