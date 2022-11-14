#!/usr/bin/env bash
# from https://edjopato.de/post/2022/11/09-avif-jpg-jxl-webp/
# adapted from https://github.com/EdJoPaTo/rain-brainz.de/blob/87da7766c998f1707066b689d24c406e1e3c1ae5/generate.sh#L30-L51

file="some-input.jpg"
i="42"

thumb="output/${i}_thumb"
big="output/${i}_big"
download="output/${i}_download"

mkdir -p output
nice convert "$file" -strip -resize '450x300^' -gravity Center -extent '450x300' "$thumb.avif" &
nice convert "$file" -strip -resize '450x300^' -gravity Center -extent '450x300' -quality 85 -sampling-factor 4:2:0 "$thumb.jpg" &
nice convert "$file" -strip -resize '450x300^' -gravity Center -extent '450x300' -quality 85 "$thumb.jxl" &
nice convert "$file" -strip -resize '450x300^' -gravity Center -extent '450x300' -quality 85 "$thumb.webp" &
nice convert "$file" -strip -resize '2000x1500>' "$big.avif" &
nice convert "$file" -strip -resize '2000x1500>' -quality 85 -sampling-factor 4:2:0 "$big.jpg" &
nice convert "$file" -strip -resize '2000x1500>' -quality 85 "$big.jxl" &
nice convert "$file" -strip -resize '2000x1500>' -quality 85 "$big.webp" &
nice convert "$file" -strip "$download.avif" &
nice convert "$file" -strip -quality 95 -sampling-factor 4:2:0 "$download.jpg" &
nice convert "$file" -strip -quality 95 "$download.jxl" &
nice convert "$file" -strip -quality 95 "$download.webp" &
wait

exa --no-time --no-user --no-permissions --long output/
