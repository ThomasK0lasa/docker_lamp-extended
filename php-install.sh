#!/bin/bash

VER=$1

echo "--- Installing php$VER ---"

ARR=($PHP_MODULES)
MODULES=""
echo "Installing php$VER"
apt-get install -y php$VER
for i in "${ARR[@]}"
do
  echo "Installing module $i"
  apt-get install -y php$VER-$i
done

echo "--- php$VER and modules installation script finished ---"