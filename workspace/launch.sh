#!/bin/bash

function cmd()
{
    local FOLDER=/home/tknew/12metrics/keymetrics/backend/
    echo "'"'workspace 3; exec xterm -e "source ~/.bashrc && cd '$FOLDER' && '$1'"'"'"
}

CMD=$(cmd 'nodemon app.js')

echo $CMD
#i3-msg $CMD
