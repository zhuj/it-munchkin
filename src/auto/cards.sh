#!/bin/bash

ls out/card-*.png | sort > tmp-list.txt
split -l 10 tmp-list.txt tmp-list-part-

ls tmp-list-part-* | sort | while read f; do
 convert $(cat $f)\
        -set page '+%[fx:697*(t%5)]+%[fx:1062*trunc(t/5)]' \
        -background none -layers merge +repage out/combined-$f.png

 convert cards-transparent.png out/combined-$f.png -gravity center -compose over -composite out/combined-$f.png
 cp out/combined-$f.png result/combined-$f.png
done