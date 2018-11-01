#!/bin/bash

export LANG=ru_RU.UTF-8
export LANGUAGE=ru_RU
export PERLIO=:utf8

cat card-issue.csv | tail -n +2 | while IFS='|' read -r cid lvl cap bon mod ttl subttl txt fl xxx; do
 echo "id=$cid"
 echo "lvl=$lvl"
 echo "cap/bon=$cap/$bon"
 echo "mod=$mod"
 echo "title=$ttl"
 echo "subtitle=$subttl"
 echo "text=$txt"
 echo "fail=$fl"
 export CARD_ID="$cid"
 export CARD_LEVEL="$lvl"
 export CARD_CAP="$cap"
 export CARD_BONUS="$bon"
 export CARD_TITLE="$ttl"
 export CARD_QUALIFIER="$mod"
 export CARD_SUBTITLE=`echo "$subttl" | perl -ne 'print lc'`
 export CARD_TEXT="$txt"
 export CARD_FAIL=`echo "$fl" | perl -ne 'print lc' | sed -e's/cap/CAP/'`

 envsubst < card-issue.html > tmp-i-${CARD_LEVEL}-${CARD_ID}.html 
 wkhtmltoimage --crop-w 691 --crop-h 1057 tmp-i-${CARD_LEVEL}-${CARD_ID}.html out/card-i-${CARD_LEVEL}-${CARD_ID}.png & true

done

