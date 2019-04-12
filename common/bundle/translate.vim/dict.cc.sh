#!/bin/bash

trap '' HUP

# if no sound happens it probably means the translation was too many
# characters. there is a max sentence size

CACHEFOLDER="/home/shane/ws/languages/speakmp3"

function getlastjob {
    jobs | grep + | cut -d ] -f 1 | tr -d '['
}

WGET_ARGS="--waitretry=3 --read-timeout=6 --tries=inf"

OPTIONS="$3"

FROMLANG="$1"
TOLANG="$2"

SCRIPT="$(cat | tr -s '/' ' ' | sed 's/[.!]$//' | tr -d '(' | tr -d ')' | awk -f /home/shane/computer/programs/awk/scripts/remove-surrounding-whitespace.awk)"
SCRIPTL="$(echo -n "$SCRIPT" | tr -d ',' | tr '[:upper:]' '[:lower:]')"
if [ -z "$SCRIPT" ]; then
    exit
fi
DICTCCFILE="${CACHEFOLDER}/$(echo -n "${SCRIPTL}_${FROMLANG}_${TOLANG}").dict.cc.txt"
TRANFILE="${CACHEFOLDER}/$(echo -n "${SCRIPTL}_${FROMLANG}_${TOLANG}").txt"
TRANFILEFIX="${CACHEFOLDER}fixes/$(echo -n "${SCRIPTL}_${FROMLANG}_${TOLANG}").txt"

if [ -f "$DICTCCFILE" ]; then
    DICTCC="$(cat "$DICTCCFILE")"
else
    #dict.cc.py --max-results 0 $FROMLANG $TOLANG "$SCRIPT"|grep "\.\.\.\.\."|sed "s/.*\.\.\.//g" > "$DICTCCFILE" 2>/dev/null &
    DICTCC="$(dict.cc.py --max-results 200 $FROMLANG $TOLANG "$SCRIPT")"
    DICTJOB="$(getlastjob)"
fi

if [ -f "$TRANFILEFIX" ]; then
    TRANS="$(cat "$TRANFILEFIX")"
elif [ -f "$TRANFILE" ]; then
    TRANS="$(cat "$TRANFILE")"
else
    #dict.cc.py $FROMLANG $TOLANG "$SCRIPT"|grep "\.\.\.\.\."|sed "s/.*\.\.\.//g" > "$TRANFILE" 2>/dev/null
    echo "$SCRIPT" | trans -no-ansi -b -s $FROMLANG -t $TOLANG | sed "s/ '/'/g" | tr -d '\000' > "$TRANFILE" 2>/dev/null
    TRANS="$(cat "$TRANFILE")"
    if [ -f "$TRANFILE" ] && [[ $(wc -c "$TRANFILE" | cut -f 1 -d ' ') -eq 0 ]]; then rm "$TRANFILE"; fi
fi
TRANS="$(echo "$TRANS" | sed 's/[.!]$//' | awk -f /home/shane/computer/programs/awk/scripts/remove-surrounding-whitespace.awk)"
TRANSL="$(echo -n "$TRANS" | sed "s/\'//g" | tr '[:upper:]' '[:lower:]')"

TRANSURI="$(echo "$TRANS" | node /home/shane/computer/programs/node/scripts/uriencodecomponent.js)"
SCRIPTURI="$(echo "$SCRIPT" | node /home/shane/computer/programs/node/scripts/uriencodecomponent.js)"

TRANSURI="$(echo "$TRANSURI" | awk -f /home/shane/computer/programs/awk/scripts/remove-surrounding-whitespace.awk)"
SCRIPTURI="$(echo "$SCRIPTURI" | awk -f /home/shane/computer/programs/awk/scripts/remove-surrounding-whitespace.awk)"

FROMFILE="${CACHEFOLDER}/$(echo -n "${SCRIPTL}_${FROMLANG}").mp3"
FROMFILEFIX="${CACHEFOLDER}fixes/$(echo -n "${SCRIPTL}_${FROMLANG}").mp3"
TOFILE="${CACHEFOLDER}/$(echo -n "$( echo "${TRANSL}" | sed 's/\///g' )_${TOLANG}").mp3"
FROMURL="http://translate.google.com/translate_tts?ie=UTF-8&fl=$FROMLANG&tl=$FROMLANG&q=$SCRIPTURI"
TOURL="http://translate.google.com/translate_tts?ie=UTF-8&fl=$TOLANG&tl=$TOLANG&q=$TRANSURI"
if [ ! -f "$FROMFILE" ]; then
    wget $WGET_ARGS -q -U Mozilla "$FROMURL" -O "$FROMFILE" &> /dev/null &
    if [ -f "$FROMFILE" ] && [[ $(wc -c "$FROMFILE" | cut -f 1 -d ' ') -eq 0 ]]; then rm "$FROMFILE"; fi
fi
FIRST="$(getlastjob)"
(
if [ "$FROMLANG" != "en" ]; then
    if [ ! -f "$TOFILE" ]; then
        if [ ! "$2" == "dlonly" ]; then
            sleep 2
        fi
        wget $WGET_ARGS -q -U Mozilla "$TOURL" -O "$TOFILE" &> /dev/null
        if [ -f "$TOFILE" ] && [[ $(wc -c "$TOFILE" | cut -f 1 -d ' ') -eq 0 ]]; then rm "$TOFILE"; fi
    fi
fi
) &

wait %$FIRST 2>/dev/null
if [ -n "$DICTJOB" ]; then
    wait %$DICTJOB 2>/dev/null
    echo -n"$DICTCC" > "$DICTCCFILE" 2>/dev/null
fi
echo -n "$DICTCC"
