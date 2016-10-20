#!/bin/bash

if [ -z "$1" ]
then
printf "$0 [link] [anime name]\n"
exit
fi

mkdir "$2"

printf "\x1b[31mDownloading Page..."
wget -q -O "$2/temp.html" $1
printf "\x1b[36mDone\n\x1b[31mExtracting links..."
grep -Po '(?<=href=")[^"]*subbed/' "$2/temp.html" > "$2/temp.txt"
printf "\x1b[36mDone\n"
printf "\x1b[31mExtracting download page links from pages..."
while read line
do
wget -q -O "$2/temp.html" $line
grep -Po '(?<=href=")http://download[^"]*' "$2/temp.html" >> "$2/links.txt"
done < "$2/temp.txt"

printf "\x1b[36mDone\n"
printf "\x1b[31mFetching direct download links..."


while read line
do
wget -q -O "$2/temp.html" $line
grep -Po '(?<=href=")http://cache[^"]*' "$2/temp.html" >> "$2/final.txt"
done < "$2/links.txt"
rm "$2/links.txt"
tac "$2/final.txt" >> "$2/links.txt"
rm "$2/temp.txt" "$2/temp.html" "$2/final.txt"

printf "\x1b[36mDone\n\x1b[0m"