# !/bin/bash
cp ~/git/dotfiles/ascii-characters/mechanic.txt ~/ascii.txt
clear -x

echo "                     "
cat ~/ascii.txt

echo "                     "
echo " ~ Nova              "
echo "                     "
sleep 2
echo "  Welcome back matti!"
sleep 1
echo "  If you need assistance just call my name."
sleep 1
echo "  But please don't break anything..."
echo "                     "
sleep 1
source "$HOME/git/dotfiles/start-ssh-agent.sh"
echo "                     "
