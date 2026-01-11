#!/bin/sh

ICONS=(
  󰎡
  󰎤
  󰎧
  󰎪
  󰎭
  󰎱
  󰎳
  󰎶
  󰎹
  󰎼
  󰬈
  󰬉
)
THREAD=0
CURR_STAT=$(cat /proc/stat)
touch ~/.config/waybar/scripts/procdata
PREV_STAT=$(cat ~/.config/waybar/scripts/procdata)
> ~/.config/waybar/scripts/procdata

OUTPUT=""
for icon in ${ICONS[@]}; do
  NEW_ROW=$(echo "$CURR_STAT" | grep "cpu${THREAD} ")
  NEW_BUSY=$(($(echo $NEW_ROW | cut -d" " -f2,3,4,7,8,9 | sed "s/ /+/g")))
  NEW_IDLE=$(($(echo $NEW_ROW | cut -d" " -f5,6 | sed "s/ /+/g")))
  NEW_TOTAL=$(("${NEW_BUSY}+${NEW_IDLE}"))

  echo "-${NEW_BUSY} -${NEW_TOTAL}" >> ~/.config/waybar/scripts/procdata
  THREAD=$(($THREAD + 1))

  OLD_ROW=$(echo "$PREV_STAT" | sed "${THREAD}q;d")
  OLD_BUSY=$(echo $OLD_ROW | cut -d" " -f1)
  OLD_TOTAL=$(echo $OLD_ROW | cut -d" " -f2)

  USED=$((("${NEW_BUSY}${OLD_BUSY}") * 100 / ("${NEW_TOTAL}${OLD_TOTAL}")))
  if [ $USED -lt 100 ]; then
    USED=" ${USED}"
  fi

  if [ $USED -lt 10 ]; then
    USED=" ${USED}"
  fi

  OUTPUT="${OUTPUT}${USED} <span size='xx-large' rise='-4000'>${icon}</span>"
done

echo "$OUTPUT "
