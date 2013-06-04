#!/bin/zsh
source ~/.zshrc
while [ true ] ; do
    ping -c 3 $1 > /dev/null
    if [ $? -ne 0 ] ; then
        terminal-notifier -title "$1: lost connection" -message "`date` Trying again in 10 secs" -activate com.apple.Terminal > /dev/null
        sleep 10;
    fi
done
