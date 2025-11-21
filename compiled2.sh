#!/bin/bash

shopt -s globstar nullglob

for file in **/*.d2; do
    png_file="${file%.d2}.png"
    svg_file="${file%.d2}.svg"
    echo "Generating PNG: $png_file"
    d2 --layout elk --dark-theme 200 "$file" "$png_file"
    echo "Generating SVG: $svg_file"
    d2 --layout elk --dark-theme 200 "$file" "$svg_file"
done

echo "All files processed."
