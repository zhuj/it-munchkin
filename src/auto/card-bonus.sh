#!/bin/bash

export LANG=ru_RU.UTF-8
export LANGUAGE=ru_RU
export PERLIO=:utf8

cat card-bonus.csv | tail -n +2 | while IFS='|' read -r cid lvl ttl subttl txt xxx; do
 echo "id=$cid"
 echo "lvl=$lvl"
 echo "title=$ttl"
 echo "subtitle=$subttl"
 echo "text=$txt"
 echo "fail=$fl"
 export CARD_ID="$cid"
 export CARD_LEVEL="$lvl"
 export CARD_TITLE="$ttl" # `echo "$ttl" | perl -ne 'print uc'`
 export CARD_SUBTITLE=`echo "$subttl" | perl -ne 'print lc'`
 export CARD_TEXT="$txt"

 [ -f image-b-${CARD_LEVEL}-${CARD_ID}.png ] || touch image-b-${CARD_LEVEL}-${CARD_ID}.png

 envsubst < card-bonus.html > tmp-b-${CARD_LEVEL}-${CARD_ID}.html 
 wkhtmltoimage --crop-w 691 --crop-h 1057 tmp-b-${CARD_LEVEL}-${CARD_ID}.html out/card-b-${CARD_LEVEL}-${CARD_ID}.png & true

done

