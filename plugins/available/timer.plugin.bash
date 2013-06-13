#!/bin/bash
gxmessage 'load cfg file'
# you may override any of the exported variables below in your .bash_profile


if [ -z "$OFER_DIR" ]; then

export OFER_DIR=$BASH_IT/custom/ofer1
   # export OFER_DIR=$BASH_IT/ofer  # store timer items in user's custom dir, ignored by git

fi


if [ -z "$TIMER_DIR" ]; then
    export TIMER_DIR=$BASH_IT/custom  # store timer items in user's custom dir, ignored by git

#export OFER_DIR="$BASH_IT/custom/ofer1"
   # export OFER_DIR=$BASH_IT/ofer  # store timer items in user's custom dir, ignored by git

fi
if [ -z "$TIMERTXT_DEFAULT_ACTION" ]; then
    export TIMERTXT_DEFAULT_ACTION=ls       # typing 't' by itself will list current timers
fi
if [ -z "$TIMER_SRC_DIR" ]; then
    export TIMER_SRC_DIR=$BASH_IT/plugins/available/timer
fi
#if [ -z "$TIMERTXT_CFG_FILE" ]; then

#export TIMERTXT_CFG_FILE=$TIMER_SRC_DIR/timer.cfg
   # export OFER_DIR=$BASH_IT/ofer  # store timer items in user's custom dir, ignored by git

#fi

# respect ENV var set in .bash_profile, default is 't'
#echo "$OFER_DIR"
alias $TIMER='$TIMER_SRC_DIR/timer.sh -d $TIMER_SRC_DIR/timer.cfg'

#export PATH=$PATH:$TIMER_SRC_DIR
source $TIMER_SRC_DIR/timer_completion   # bash completion for timer.sh
complete -F _timer $TIMER                # enable completion for 't' alias
