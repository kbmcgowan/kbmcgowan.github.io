#!/bin/bash

export UTTS=../utts.data

echo which file are we starting with [ 1 = first ]?
read START;

if [ "$START" == "" ]; then
     START=1
fi

for i in `ls a*.wav | sort -n -k1.2`; do
    num=`printf "%04d" $START`

    line=`grep "audio_$num" $UTTS`
    prompt=`echo $line | awk -F\" '{print $2}'`
    echo $line
    afplay $i;
    echo make $i $num [y] ?;

    read ANSWER;

    if [ "$ANSWER" == "n" ]; then
        echo doing nothing
    else
        if [ "$ANSWER" == "p" ]; then
            let "START = START - 1"
            num=`printf "%04d" $START`

            echo overwriting $i to $num ...
        else
            echo saving $i to $num ...
        fi

        cp $i audio_${num}.wav
        cp oaf_$i oaf_${num}.wav
        cp naf_$i naf_${num}.wav
        echo $prompt > ${num}.txt
        rm $i

        let "START = START + 1"
    fi
done

