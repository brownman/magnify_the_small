#!/bin/bash
#nvm use 0.8
echo "commands.sh"
. ~/.profile
path1=/TORRENTS/JAVASCRIPT/casperjs
lang="$1"
str="$2"
script_js="$3"
echo "lang: $1 || str: $2" 
$path1/bin/casperjs $script_js --target="$lang" "$str" > /tmp/test1.html

#cat /tmp/test1.html | head -1

exo-open /tmp/test1.html
sleep 5

#./bin/casperjs ./samples/translate.coffee --target=ru 'small' | grep noun
#grep fetchText . -r
#./bin/casperjs ./samples/translate.js --target=ru 'nice' > test1.html
#grep timeout . -r