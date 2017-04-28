#!/bin/bash
files=*.m4a
#create output folder if it doesnt exist
if [ ! -d Mp3 ]; then
        mkdir Mp3
fi

for file in $files; do
        mp3File=${file/%m4a/mp3}
        avconv -y -i "${file}" -f ffmetadata metadata.txt
        sed -e 's/^date=\(.*\)$/TYER=\1/' -e 's/^major_brand=.*$//' -e 's/^minor_version=.*$//' -e 's/^creation.*$//' -e 's/^compatible.*$//' -e 's/^encoder=.*$//' <metadata.txt >metadata2.txt
        avconv -y -i "${file}" -i metadata2.txt -ab 320k -map_metadata 1 -id3v2_version 3 "Mp3/${mp3File}"
done
