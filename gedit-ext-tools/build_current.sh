#!/bin/sh
EHOME=`echo $HOME | sed "s/#/\#/"`
DIR=$GEDIT_CURRENT_DOCUMENT_DIR
while test "$DIR" != "/"; do
    for m in GNUmakefile makefile Makefile; do
        if [ -f "${DIR}/${m}" ]; then
            echo "Using ${m} from ${DIR}" | sed "s#$EHOME#~#" > /dev/stderr
            DESU=`echo ${GEDIT_CURRENT_DOCUMENT_NAME}|cut -d "." -f 1`
            make -C "${DIR}" $DESU
            exit
        fi
    done
    DIR=`dirname "${DIR}"`
done
echo "No Makefile found!" > /dev/stderr
