#!/bin/sh

MEMFREE=$(cat /proc/meminfo | grep MemAvailable | sed "s/[^0-9]*//g")
MEMTOTAL=$(cat /proc/meminfo | grep MemTotal | sed "s/[^0-9]*//g")
USED=$((100 - $MEMFREE * 100 / $MEMTOTAL))
if [ $USED -lt 100 ]; then
  USED=" ${USED}"
fi

if [ $USED -lt 10 ]; then
  USED=" ${USED}"
fi

echo "${USED} <span size='xx-large' rise='-4000'>󰟜</span> "
