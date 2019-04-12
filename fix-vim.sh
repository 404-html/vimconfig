#!/bin/bash
#find . -type l -xtype l|less -S > broken-symlinks.txt
TOP="$(pwd)"
cat broken-symlinks.txt|while read line; do
OPATH="$line"
cd "$TOP"
DIR="$(dirname "$OPATH")"
FILE="$(basename "$OPATH")"
cd "$DIR"
DEST="$(readlink "$FILE")"
#if [[ "$DEST" == *"/external/"* ]]; then
#    NEWDEST="${DEST/external/common}"
#    ln -sf "$NEWDEST"
#if [ -d "$DEST" ] && [[ "$DIR" == *"/external/"* ]]; then
if [ ! -e "$FILE" ] && [[ "$DIR" == *"/external/"* ]]; then
    NEWPATH="${OPATH/external/common}"
    NEWFULLPATH="${TOP}/$NEWPATH"
    NEWFULLDIR="$(dirname "$NEWFULLPATH")"
    if [ -d "$HOME/build/versioned/git/$FILE" ]; then
        rm "$FILE"
        cp -a "$HOME/build/versioned/git/$FILE" "${NEWFULLPATH}"
        echo "$DEST, ${NEWFULLPATH}"
    fi

    #mkdir -p "$NEWFULLDIR"
    #rm "$FILE"
    #cp -a "$DEST" "${NEWFULLPATH}"
else
    :
    #echo "$DEST, ${NEWFULLPATH}"
fi
#echo "$(pwd),${line},${DEST}"
done
