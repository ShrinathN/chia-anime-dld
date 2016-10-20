#!/bin/bash

if [ -z "$1" ]
then
echo "$0 [link] [anime name]"
exit
fi

mkdir "$2"

echo "Downloading Page..."
wget -q -O "$2/temp.html" $1
echo "Done"
echo "Extracting links..."
grep -Po '(?<=href=")[^"]*subbed/' "$2/temp.html" > "$2/temp.txt"
echo "Done"
echo "Extracting download page links from pages..."
while read line
do
wget -q -O "$2/temp.html" $line
grep -Po '(?<=href=")http://download[^"]*' "$2/temp.html" >> "$2/links.txt"
done < "$2/temp.txt"

echo "Done"
echo "Fetching direct download links..."


while read line
do
wget -q -O "$2/temp.html" $line
grep -Po '(?<=href=")http://cache[^"]*' "$2/temp.html" >> "$2/final.txt"
done < "$2/links.txt"
rm "$2/links.txt"
tac "$2/final.txt" >> "$2/links.txt"
rm "$2/temp.txt" "$2/temp.html" "$2/final.txt"

echo "Done"