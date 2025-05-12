#!/bin/bash

found_cow=$(find /usr /opt -name '*.cow' 2>/dev/null | tail -n 1)

if [ -z "$found_cow" ]; then
  echo "No cow files found! Exiting."
  exit 1
fi

cowsdir=$(dirname "$found_cow")

cows_present=$(find "$cowsdir" -type f -name '*.cow' | wc -l)

echo "Who left the barn door open? Was it you, $(whoami)? It looks like your cows are in $cowsdir. (There were $cows_present cows in there, anyway.)"

sleep 1 && echo "Injecting cutting-edge cowlishness..."

if [ ! -d "./cows" ] || [ "$(ls ./cows/*.cow 2>/dev/null | wc -l)" -eq 0 ]; then
  echo "No cows to add from ./cows! Exiting."
  exit 1
fi

sudo cp ./cows/*.cow "$cowsdir"

the_chosen_cow=$(basename "$(find ./cows -type f -name '*.cow' | shuf -n 1)")

cows_now=$(find "$cowsdir" -type f -name '*.cow' | wc -l)

added_cows=$((cows_now - cows_present))

congratulate_yourself="Congrats, $(whoami), you are now the proud owner of $added_cows new cows... $cows_now in total."
echo "$congratulate_yourself" | cowsay -f "$cowsdir/$the_chosen_cow"
