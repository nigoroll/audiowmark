#!/bin/bash

TRUNCATE="60 110 245"

for TRUNC in 60 110 245
do
echo ".sync-codec-resistence$TRUNC"
echo '[frame="topbot",options="header",cols="<2,6*>1"]'
echo '|=========================='
echo -n "| "
for STRENGTH in $(seq 10 -1 5)
do
  echo -n "| $STRENGTH"
done
echo
for TEST in mp3 double-mp3 ogg
do
  if [ $TEST == mp3 ]; then
    echo -n "| mp3 128kbit/s"
  elif [ $TEST == double-mp3 ]; then
    echo -n "| double mp3 128kbit/s"
  elif [ $TEST == ogg ]; then
    echo -n "| ogg 128kbit/s"
  else
    echo "error: bad TEST $TEST ???"
    exit 1
  fi
  for STRENGTH in $(seq 10 -1 5)
  do
    cat $STRENGTH-$TEST-* | grep -v '^#' | grep ^$TRUNC | awk '{bad += $2; n += $3} END {if (n==0) n=1;fer=100.0*bad/n; bold=fer>0?"*":" ";printf ("| %s%.2f%s", bold, fer, bold)}'
  done
  echo
done
echo
echo '|=========================='
done
