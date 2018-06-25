#!/usr/bin/env bash

mkdir -p reactions

for word in $(cat stimul.txt); do
    ./ass.sh $word > "reactions/${word}.txt"
done
