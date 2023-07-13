#!/bin/bash


# Requirements:
#       - ImageMagick
#       - exiftool


# USAGE:
# run this script IN the folder containing the pictures
compresss_images.sh [COMPRESSION_FACTOR 0-100]


# TODO:
#       - create folder and proceed to compression
#       only if at least one image file exists
#       - add better usage documentation
#       - add feature to specify the folder containing images to be compressed


BACKUP_DIR="0_original_pics"
COMPRESSION_FACTOR_DEFAULT="80"

compression_factor="${1:-$COMPRESSION_FACTOR_DEFAULT}"
echo "compression_factor is set to $compression_factor%"

function isImage(){
    isImage=$(echo "$filename" | grep -iE "jpg|png|jpeg|webp|bmp")
    [[ -n "$isImage" ]]
}

mkdir -p "$BACKUP_DIR"

for filename in ./*
do
    if isImage "$filename"; then
        #echo  "$filename"
        mv "$filename" "$BACKUP_DIR"
    fi
done

#: '
cd "$BACKUP_DIR"

for filename in ./*
do
    if isImage "$filename"; then
        echo "compressing $filename"
        convert -strip -interlace Plane -gaussian-blur 0.05 -quality "$compression_factor%" "$filename" ../"$filename"
        exiftool -TagsFromFile "$filename" ../"$filename" -overwrite_original
        touch -r "$filename" ../"$filename" # preserve file modify time
    fi
done
#'
