#!/bin/bash

ls out/* | sort > tmp-list.txt
split -l 10 tmp-list.txt tmp-list-part-

ls tmp-list-part-* | sort | while read f; do
 convert $(cat $f)\
        -set page '+%[fx:697*(t%5)]+%[fx:1062*trunc(t/5)]' \
        -background none -layers merge +repage tmp-$f.png

 convert cards-transparent.png tmp-$f.png overlayimage -gravity center -compose over -composite tmp-$f.png
done