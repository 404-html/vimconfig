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
if [ "$OPTIONS" == "dlonly"  ]; then
    echo -n "$SCRIPT "
elif [ "$OPTIONS" == "translate"  ]; then
    :
else
    echo -n "$SCRIPT "
fi
DICTCCFILE="${CACHEFOLDER}/$(echo -n "${SCRIPTL}_${FROMLANG}_${TOLANG}").dict.cc.txt"
TRANFILE="${CACHEFOLDER}/$(echo -n "${SCRIPTL}_${FROMLANG}_${TOLANG}").txt"
TRANFILEFIX="${CACHEFOLDER}fixes/$(echo -n "${SCRIPTL}_${FROMLANG}_${TOLANG}").txt"

if [ -f "$DICTCCFILE" ]; then
    DICTCC="$(cat "$DICTCCFILE")"
else
    if [[ "$FROMLANG" == "en" || "$FROMLANG" == "de" || "$FROMLANG" == "fr" ]]; then
        #dict.cc.py --max-results 0 $FROMLANG $TOLANG "$SCRIPT"|grep "\.\.\.\.\."|sed "s/.*\.\.\.//g" > "$DICTCCFILE" 2>/dev/null &
        dict.cc.py --max-results 200 $FROMLANG $TOLANG "$SCRIPT" > "$DICTCCFILE" 2>/dev/null &
        DICTJOB="$(getlastjob)"
    fi
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

if [ ! -f "$FROMFILE" ]; then
    wget $WGET_ARGS -q -U Mozilla "$FROMURL" -O "$FROMFILE" &> /dev/null &
    FROMMP3JOB="$(getlastjob)"
    DLFROM=dlfrom
fi

if [ ! -f "$TOFILE" ]; then
    wget $WGET_ARGS -q -U Mozilla "$TOURL" -O "$TOFILE" &> /dev/null &
    TOMP3JOB="$(getlastjob)"
    DLTO=dlto
fi

if [ "$OPTIONS" == "speak"  ]; then
    if [ -n "$DLFROM" ]; then
        wait %$FROMMP3JOB 2>/dev/null
    fi
    echo "$TRANS"
    if [ -f "$FROMFILEFIX" ]; then
        if [[ $(wc -c "$FROMFILEFIX" | cut -f 1 -d ' ') -eq 0 ]]; then
            rm "$FROMFILEFIX"
        else
            vlc --gain 0.4 --intf dummy --play-and-exit -- "$FROMFILEFIX" 2>/dev/null
        fi
    elif [ -f "$FROMFILE" ]; then
        if [[ $(wc -c "$FROMFILE" | cut -f 1 -d ' ') -eq 0 ]]; then
            rm "$FROMFILE"
        else
            vlc --gain 0.4 --intf dummy --play-and-exit -- "$FROMFILE" 2>/dev/null
        fi
    fi

    if [ -n "$DICTJOB" ]; then
        wait %$DICTJOB 2>/dev/null
        DICTCC="$(cat "$DICTCCFILE")"
        if [ -f "$DICTCCFILE" ] && [[ $(wc -c "$DICTCCFILE" | cut -f 1 -d ' ') -eq 0 ]]; then rm "$DICTCCFILE"; fi
    fi
    exit
fi

if [ "$OPTIONS" == "translate"  ]; then
    echo -n "$TRANS"

    if [ -n "$DICTJOB" ]; then
        wait %$DICTJOB 2>/dev/null
        DICTCC="$(cat "$DICTCCFILE")"
        if [ -f "$DICTCCFILE" ] && [[ $(wc -c "$DICTCCFILE" | cut -f 1 -d ' ') -eq 0 ]]; then rm "$DICTCCFILE"; fi
    fi

    wait %$TOMP3JOB 2>/dev/null
    if [ -f "$TOFILE" ] && [[ $(wc -c "$TOFILE" | cut -f 1 -d ' ') -eq 0 ]]; then rm "$TOFILE"; fi
    exit
fi

if [ ! "$OPTIONS" == "dlonly" ]; then
    if [ "$FROMLANG" == "$TOLANG" ]; then
        vlc --gain 0.4 --intf dummy --play-and-exit -- "$TOFILE" 2>/dev/null &
        SECOND="$(getlastjob)"

        if [ -n "$DICTJOB" ]; then
            wait %$DICTJOB 2>/dev/null
            DICTCC="$(cat "$DICTCCFILE")"
            if [ -f "$DICTCCFILE" ] && [[ $(wc -c "$DICTCCFILE" | cut -f 1 -d ' ') -eq 0 ]]; then rm "$DICTCCFILE"; fi
        fi

        if [ -n "$DLTO" ]; then
            wait %$TOMP3JOB 2>/dev/null
        fi
        if [ -f "$TOFILE" ] && [[ $(wc -c "$TOFILE" | cut -f 1 -d ' ') -eq 0 ]]; then rm "$TOFILE"; fi
        exit
    fi

    wait %$FROMMP3JOB 2>/dev/null
    if [ -f "$FROMFILE" ] && [[ $(wc -c "$FROMFILE" | cut -f 1 -d ' ') -eq 0 ]]; then rm "$FROMFILE"; fi

    vlc --intf dummy --play-and-exit -- "$FSPEAK" 2>/dev/null &
    FIRSTVLC="$(getlastjob)"
    wait %$FIRSTVLC 2>/dev/null
    wait %$SECOND 2>/dev/null
    sleep 0.5
    #vlc --gain 0.4 --intf dummy --play-and-exit -- "$TOFILE" 2>/dev/null &
    echo "- $TRANS"
    #SECONDVLC="$(getlastjob)"
    #wait %$SECONDVLC 2>/dev/null
    #vlc --intf dummy --play-and-exit -- "$FSPEAK" 2>/dev/null &
    #FIRSTVLC="$(getlastjob)"
    #wait %$FIRSTVLC 2>/dev/null
    sleep 0.5
    #vlc --intf dummy --play-and-exit -- "$FSPEAK" 2>/dev/null &
    #FIRSTVLC="$(getlastjob)"
    #wait %$FIRSTVLC 2>/dev/null
else
    echo
fi

if [ -n "$DICTJOB" ]; then
    wait %$DICTJOB 2>/dev/null
    DICTCC="$(cat "$DICTCCFILE")"
    if [ -f "$DICTCCFILE" ] && [[ $(wc -c "$DICTCCFILE" | cut -f 1 -d ' ') -eq 0 ]]; then rm "$DICTCCFILE"; fi
fi
