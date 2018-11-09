#!/bin/bash

export LANG=ru_RU.UTF-8
export LANGUAGE=ru_RU
export PERLIO=:utf8

cat card-curse.csv | tail -n +2 | while IFS='|' read -r cid mod ttl subttl txt fl xxx; do
 echo "id=$cid"
 echo "mod=$mod"
 echo "title=$ttl"
 echo "subtitle=$subttl"
 echo "text=$txt"
 echo "fail=$fl"
 export CARD_ID="$cid"
 export CARD_LEVEL="0"
 export CARD_TITLE="$ttl"
 export CARD_QUALIFIER="$mod"
 export CARD_SUBTITLE=`echo "$subttl" | perl -ne 'print lc' | sed -e's/cap/CAP/'`
 export CARD_TEXT="$txt"
 export CARD_FAIL=`echo "$fl" | perl -ne 'print lc' | sed -e's/cap/CAP/'`

 [ -f image-c-${CARD_LEVEL}-${CARD_ID}.png ] || touch image-c-${CARD_LEVEL}-${CARD_ID}.png

 envsubst < card-curse.html > tmp-c-${CARD_LEVEL}-${CARD_ID}.html
 wkhtmltoimage --crop-w 691 --crop-h 1057 tmp-c-${CARD_LEVEL}-${CARD_ID}.html out/card-c-${CARD_LEVEL}-${CARD_ID}.png & true

done

