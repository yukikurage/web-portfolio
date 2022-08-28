#!/bin/bash

PARAMS=('-m 6 -q 70 -mt -af -progress')

if [ $# -ne 0 ]; then
	PARAMS=$@;
fi

cd $(pwd)/public/img/

cd $(pwd)/800

shopt -s nullglob nocaseglob extglob

for FILE in *.@(jpg|jpeg|tif|tiff|png); do
    cwebp $PARAMS "$FILE" -o "./webp/${FILE%.*}".webp -resize 800 0;
done

cd ..

cd $(pwd)/1000

shopt -s nullglob nocaseglob extglob

for FILE in *.@(jpg|jpeg|tif|tiff|png); do
    cwebp $PARAMS "$FILE" -o "./webp/${FILE%.*}".webp -resize 1000 0;
done

cd ..
