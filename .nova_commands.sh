#!/bin/bash

function novaBase() {
  cp ~/git/dotfiles/ascii-characters/mechanic.txt ~/ascii.txt
  clear -x

  echo "                     "
  cat ~/ascii.txt

  echo "                     "
  echo " ~ Nova              "

}

# Nova, commands to follow here
function nova() {
  novaBase

  echo "                     "
  echo "  Why hello there!"
  sleep 2
  echo "  I would love to help you"
  sleep 2
  echo "  Only if you didn't suck though"
  echo "                     "
  sleep 1
}
