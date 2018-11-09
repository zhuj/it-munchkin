#!/bin/bash

export LANG=ru_RU.UTF-8
export LANGUAGE=ru_RU
export PERLIO=:utf8

cat card-role.csv | tail -n +2 | while IFS='|' read -r cid lvl mod ttl subttl txt1 txt2 fl xxx; do
 echo "id=$cid"
 echo "lvl=$lvl"
 echo "mod=$mod"
 echo "title=$ttl"
 echo "subtitle=$subttl"
 echo "text=$txt1/$txt2"
 echo "fail=$fl"
 export CARD_ID="$cid"
 export CARD_LEVEL="$lvl"
 export CARD_TITLE="$ttl"
 export CARD_QUALIFIER="$mod"
 export CARD_SUBTITLE=`echo "$subttl" | perl -ne 'print lc' | sed -e's/cap/CAP/' | sed -e's/sp/SP/' `
 export CARD_TEXT1="$txt1"
 export CARD_TEXT2="$txt2"
 export CARD_FAIL=`echo "$fl" | perl -ne 'print lc' | sed -e's/cap/CAP/' | sed -e's/sp/SP/'`

 [ -f image-r-${CARD_LEVEL}-${CARD_ID}.png ] || touch image-r-${CARD_LEVEL}-${CARD_ID}.png

 envsubst < card-role.html > tmp-r-${CARD_LEVEL}-${CARD_ID}.html
 wkhtmltoimage --crop-w 691 --crop-h 1057 tmp-r-${CARD_LEVEL}-${CARD_ID}.html out/card-i-r-${CARD_LEVEL}-${CARD_ID}.png & true

done

