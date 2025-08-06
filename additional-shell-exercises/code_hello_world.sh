#!/bin/bash

# Encrypted base-5 strings
VAR1="rdcm"        # Uses alphabet: mrdoc
VAR2="'?!\\"       # Uses alphabet: ' ? ! \
VAR3="mroc"        # Uses alphabet: mrdoc



# Pipeline: decode, add, convert to base-11, map to "HELLO WORLD"
echo "$VAR1 + $VAR2 + $VAR3" | \
  sed "s/'/0/g" | \
  tr 'mrdoc\\\?\!' '01234' | \
  xargs echo "obase=11; ibase=5;" | \
  bc | \
  tr '0123456789A' 'HELLO WORLD'


