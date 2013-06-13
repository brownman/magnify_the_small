#! /bin/bash

# === HEAVY LIFTING ===
shopt -s extglob extquote

# NOTE:  timer.sh requires the .timer/config configuration file to run.
# Place the .timer/config file in your home directory or use the -d option for a custom location.

[ -f VERSION-FILE ] && . VERSION-FILE || VERSION="2.9"
version() {
    cat <<-EndVersion
		TIMER.TXT Command Line Interface v$VERSION

		First release: 5/11/2006
		Original conception by: Gina Trapani (http://ginatrapani.org)
		Contributors: http://github.com/ginatrapani/timer.txt-cli/network
		License: GPL, http://www.gnu.org/copyleft/gpl.html
		More information and mailing list at http://timertxt.com
		Code repository: http://github.com/ginatrapani/timer.txt-cli/tree/master
	EndVersion
    exit 1
}

# Set script name and full path early.
TIMER_SH=$(basename "$0")

echo "timer.sh is: $TIMER_SH"
TIMER_FULL_SH="$0"

echo "timer full_sh is: $TIMER_FULL_SH"
export TIMER_SH TIMER_FULL_SH

oneline_usage="$TIMER_SH [-fhpantvV] [-d timer_config] action [task_number] [task_description]"

usage()
{
    cat <<-EndUsage
		Usage: $oneline_usage
		Try '$TIMER_SH -h' for more information.
	EndUsage
    exit 1
}

shorthelp()
{
    cat <<-EndHelp
		  Usage: $oneline_usage

		  Actions:
            
            timer_run "Run the timer.sh"
		    add|a "THING I NEED TO DO +project @context"
		    addm "THINGS I NEED TO DO
		          MORE THINGS I NEED TO DO"
		    addto DEST "TEXT TO ADD"
		    append|app ITEM# "TEXT TO APPEND"
		    archive
		    command [ACTIONS]
		    deduplicate
		    del|rm ITEM# [TERM]
		    depri|dp ITEM#[, ITEM#, ITEM#, ...]
		    do ITEM#[, ITEM#, ITEM#, ...]
		    help
		    list|ls [TERM...]
		    listall|lsa [TERM...]
		    listaddons
		    listcon|lsc
		    listfile|lf [SRC [TERM...]]
		    listpri|lsp [PRIORITIES] [TERM...]
		    listproj|lsprj [TERM...]
		    move|mv ITEM# DEST [SRC]
		    prepend|prep ITEM# "TEXT TO PREPEND"
		    pri|p ITEM# PRIORITY
		    replace ITEM# "UPDATED TIMER"
		    report
		    shorthelp

		  Actions can be added and overridden using scripts in the actions
		  directory.
	EndHelp

    # Only list the one-line usage from the add-on actions. This assumes that
    # add-ons use the same usage indentation structure as timer.sh.
    addonHelp | grep -e '^  Add-on Actions:' -e '^    [[:alpha:]]'

    cat <<-EndHelpFooter

		  See "help" for more details.
	EndHelpFooter
    exit 0
}

help()
{
    cat <<-EndOptionsHelp
		  Usage: $oneline_usage

		  Options:
		    -@
		        Hide context names in list output.  Use twice to show context
		        names (default).
		    -+
		        Hide project names in list output.  Use twice to show project
		        names (default).
		    -c
		        Color mode
		    -d CONFIG_FILE
		        Use a configuration file other than the default ~/.timer/config
		    -f
		        Forces actions without confirmation or interactive input
		    -h
		        Display a short help message; same as action "shorthelp"
		    -p
		        Plain mode turns off colors
		    -P
		        Hide priority labels in list output.  Use twice to show
		        priority labels (default).
		    -a
		        Don't auto-archive tasks automatically on completion
		    -A
		        Auto-archive tasks automatically on completion
		    -n
		        Don't preserve line numbers; automatically remove blank lines
		        on task deletion
		    -N
		        Preserve line numbers
		    -t
		        Prepend the current date to a task automatically
		        when it's added.
		    -T
		        Do not prepend the current date to a task automatically
		        when it's added.
		    -v
		        Verbose mode turns on confirmation messages
		    -vv
		        Extra verbose mode prints some debugging information and
		        additional help text
		    -V
		        Displays version, license and credits
		    -x
		        Disables TIMERTXT_FINAL_FILTER


	EndOptionsHelp

    [ $TIMERTXT_VERBOSE -gt 1 ] && cat <<-'EndVerboseHelp'
		  Environment variables:
		    TIMERTXT_AUTO_ARCHIVE            is same as option -a (0)/-A (1)
		    TIMERTXT_CFG_FILE=CONFIG_FILE    is same as option -d CONFIG_FILE
		    TIMERTXT_FORCE=1                 is same as option -f
		    TIMERTXT_PRESERVE_LINE_NUMBERS   is same as option -n (0)/-N (1)
		    TIMERTXT_PLAIN                   is same as option -p (1)/-c (0)
		    TIMERTXT_DATE_ON_ADD             is same as option -t (1)/-T (0)
		    TIMERTXT_VERBOSE=1               is same as option -v
		    TIMERTXT_DISABLE_FILTER=1        is same as option -x
		    TIMERTXT_DEFAULT_ACTION=""       run this when called with no arguments
		    TIMERTXT_SORT_COMMAND="sort ..." customize list output
		    TIMERTXT_FINAL_FILTER="sed ..."  customize list after color, P@+ hiding
		    TIMERTXT_SOURCEVAR=\$DONE_FILE   use another source for listcon, listproj


	EndVerboseHelp
    cat <<-EndActionsHelp
		  Built-in Actions:
		    add "THING I NEED TO DO +project @context"
		    a "THING I NEED TO DO +project @context"
		      Adds THING I NEED TO DO to your timer.txt file on its own line.
		      Project and context notation optional.
		      Quotes optional.

		    addm "FIRST THING I NEED TO DO +project1 @context
		    SECOND THING I NEED TO DO +project2 @context"
		      Adds FIRST THING I NEED TO DO to your timer.txt on its own line and
		      Adds SECOND THING I NEED TO DO to you timer.txt on its own line.
		      Project and context notation optional.

		    addto DEST "TEXT TO ADD"
		      Adds a line of text to any file located in the timer.txt directory.
		      For example, addto inbox.txt "decide about vacation"

		    append ITEM# "TEXT TO APPEND"
		    app ITEM# "TEXT TO APPEND"
		      Adds TEXT TO APPEND to the end of the task on line ITEM#.
		      Quotes optional.

		    archive
		      Moves all done tasks from timer.txt to done.txt and removes blank lines.

		    command [ACTIONS]
		      Runs the remaining arguments using only timer.sh builtins.
		      Will not call any .timer.actions.d scripts.

		    deduplicate
		      Removes duplicate lines from timer.txt.

		    del ITEM# [TERM]
		    rm ITEM# [TERM]
		      Deletes the task on line ITEM# in timer.txt.
		      If TERM specified, deletes only TERM from the task.

		    depri ITEM#[, ITEM#, ITEM#, ...]
		    dp ITEM#[, ITEM#, ITEM#, ...]
		      Deprioritizes (removes the priority) from the task(s)
		      on line ITEM# in timer.txt.

		    do ITEM#[, ITEM#, ITEM#, ...]
		      Marks task(s) on line ITEM# as done in timer.txt.

		    help
		      Display this help message.

		    list [TERM...]
		    ls [TERM...]
		      Displays all tasks that contain TERM(s) sorted by priority with line
		      numbers.  Each task must match all TERM(s) (logical AND); to display
		      tasks that contain any TERM (logical OR), use
		      "TERM1\|TERM2\|..." (with quotes), or TERM1\\\|TERM2 (unquoted).
		      Hides all tasks that contain TERM(s) preceded by a
		      minus sign (i.e. -TERM). If no TERM specified, lists entire timer.txt.

		    listall [TERM...]
		    lsa [TERM...]
		      Displays all the lines in timer.txt AND done.txt that contain TERM(s)
		      sorted by priority with line  numbers.  Hides all tasks that
		      contain TERM(s) preceded by a minus sign (i.e. -TERM).  If no
		      TERM specified, lists entire timer.txt AND done.txt
		      concatenated and sorted.

		    listaddons
		      Lists all added and overridden actions in the actions directory.

		    listcon
		    lsc
		      Lists all the task contexts that start with the @ sign in timer.txt.

		    listfile [SRC [TERM...]]
		    lf [SRC [TERM...]]
		      Displays all the lines in SRC file located in the timer.txt directory,
		      sorted by priority with line  numbers.  If TERM specified, lists
		      all lines that contain TERM(s) in SRC file.  Hides all tasks that
		      contain TERM(s) preceded by a minus sign (i.e. -TERM).  
		      Without any arguments, the names of all text files in the timer.txt
		      directory are listed.
		
		    listpri [PRIORITIES] [TERM...]
		    lsp [PRIORITIES] [TERM...]
		      Displays all tasks prioritized PRIORITIES.
		      PRIORITIES can be a single one (A) or a range (A-C).
		      If no PRIORITIES specified, lists all prioritized tasks.
		      If TERM specified, lists only prioritized tasks that contain TERM(s).
		      Hides all tasks that contain TERM(s) preceded by a minus sign
		      (i.e. -TERM).  

		    listproj
		    lsprj
		      Lists all the projects (terms that start with a + sign) in
		      timer.txt.

		    move ITEM# DEST [SRC]
		    mv ITEM# DEST [SRC]
		      Moves a line from source text file (SRC) to destination text file (DEST).
		      Both source and destination file must be located in the directory defined
		      in the configuration directory.  When SRC is not defined
		      it's by default timer.txt.

		    prepend ITEM# "TEXT TO PREPEND"
		    prep ITEM# "TEXT TO PREPEND"
		      Adds TEXT TO PREPEND to the beginning of the task on line ITEM#.
		      Quotes optional.

		    pri ITEM# PRIORITY
		    p ITEM# PRIORITY
		      Adds PRIORITY to task on line ITEM#.  If the task is already
		      prioritized, replaces current priority with new PRIORITY.
		      PRIORITY must be a letter between A and Z.

		    replace ITEM# "UPDATED TIMER"
		      Replaces task on line ITEM# with UPDATED TIMER.

		    report
		      Adds the number of open tasks and done tasks to report.txt.

		    shorthelp
		      List the one-line usage of all built-in and add-on actions.

	EndActionsHelp

        addonHelp
    exit 1
}

addonHelp()
{
    if [ -d "$TIMER_ACTIONS_DIR" ]; then
        didPrintAddonActionsHeader=
        for action in "$TIMER_ACTIONS_DIR"/*
        do
            if [ -f "$action" -a -x "$action" ]; then
                if [ ! "$didPrintAddonActionsHeader" ]; then
                    cat <<-EndAddonActionsHeader
		  Add-on Actions:
	EndAddonActionsHeader
                    didPrintAddonActionsHeader=1
                fi
                "$action" usage
            fi
        done
    fi
}

die()
{
    echo "$*"
    exit 1
}

cleaninput()
{
    # Parameters:    When $1 = "for sed", performs additional escaping for use
    #                in sed substitution with "|" separators.
    # Precondition:  $input contains text to be cleaned.
    # Postcondition: Modifies $input.

    # Replace CR and LF with space; tasks always comprise a single line.
    input=${input//$'\r'/ }
    input=${input//$'\n'/ }

    if [ "$1" = "for sed" ]; then
        # This action uses sed with "|" as the substitution separator, and & as
        # the matched string; these must be escaped.
        # Backslashes must be escaped, too, and before the other stuff.
        input=${input//\\/\\\\}
        input=${input//|/\\|}
        input=${input//&/\\&}
    fi
}

getPrefix()
{
    # Parameters:    $1: timer file; empty means $TIMER_FILE.
    # Returns:       Uppercase FILE prefix to be used in place of "TIMER:" where
    #                a different timer file can be specified.
    local base=$(basename "${1:-$TIMER_FILE}")
    echo "${base%%.[^.]*}" | tr 'a-z' 'A-Z'
}

gettimer()
{
    # Parameters:    $1: task number
    #                $2: Optional timer file
    # Precondition:  $errmsg contains usage message.
    # Postcondition: $timer contains task text.

    local item=$1
    [ -z "$item" ] && die "$errmsg"
    [ "${item//[0-9]/}" ] && die "$errmsg"

    timer=$(sed "$item!d" "${2:-$TIMER_FILE}")
    [ -z "$timer" ] && die "$(getPrefix "$2"): No task $item."
}
getNewtimer()
{
    # Parameters:    $1: task number
    #                $2: Optional timer file
    # Precondition:  None.
    # Postcondition: $newtimer contains task text.

    local item=$1
    [ -z "$item" ] && die 'Programming error: $item should exist.'
    [ "${item//[0-9]/}" ] && die 'Programming error: $item should be numeric.'

    newtimer=$(sed "$item!d" "${2:-$TIMER_FILE}")
    [ -z "$newtimer" ] && die "$(getPrefix "$2"): No updated task $item."
}

replaceOrPrepend()
{
  action=$1; shift
  case "$action" in
    replace)
      backref=
      querytext="Replacement: "
      ;;
    prepend)
      backref=' &'
      querytext="Prepend: "
      ;;
  esac
  shift; item=$1; shift
  gettimer "$item"

  if [[ -z "$1" && $TIMERTXT_FORCE = 0 ]]; then
    echo -n "$querytext"
    read input
  else
    input=$*
  fi
  cleaninput "for sed"

  # Retrieve existing priority and prepended date
  priority=$(sed -e "$item!d" -e $item's/^\((.) \)\{0,1\}\([0-9]\{2,4\}-[0-9]\{2\}-[0-9]\{2\} \)\{0,1\}.*/\1/' "$TIMER_FILE")
  prepdate=$(sed -e "$item!d" -e $item's/^\((.) \)\{0,1\}\([0-9]\{2,4\}-[0-9]\{2\}-[0-9]\{2\} \)\{0,1\}.*/\2/' "$TIMER_FILE")

  if [ "$prepdate" -a "$action" = "replace" ] && [ "$(echo "$input"|sed -e 's/^\([0-9]\{2,4\}-[0-9]\{2\}-[0-9]\{2\}\)\{0,1\}.*/\1/')" ]; then
    # If the replaced text starts with a date, it will replace the existing
    # date, too.
    prepdate=
  fi

  # Temporarily remove any existing priority and prepended date, perform the
  # change (replace/prepend) and re-insert the existing priority and prepended
  # date again.
  sed -i.bak -e "$item s/^${priority}${prepdate}//" -e "$item s|^.*|${priority}${prepdate}${input}${backref}|" "$TIMER_FILE"
  if [ $TIMERTXT_VERBOSE -gt 0 ]; then
    getNewtimer "$item"
    case "$action" in
      replace)
        echo "$item $timer"
        echo "TIMER: Replaced task with:"
        echo "$item $newtimer"
        ;;
      prepend)
        echo "$item $newtimer"
        ;;
    esac
  fi
}

#Preserving environment variables so they don't get clobbered by the config file
OVR_TIMERTXT_AUTO_ARCHIVE="$TIMERTXT_AUTO_ARCHIVE"
OVR_TIMERTXT_FORCE="$TIMERTXT_FORCE"
OVR_TIMERTXT_PRESERVE_LINE_NUMBERS="$TIMERTXT_PRESERVE_LINE_NUMBERS"
OVR_TIMERTXT_PLAIN="$TIMERTXT_PLAIN"
OVR_TIMERTXT_DATE_ON_ADD="$TIMERTXT_DATE_ON_ADD"
OVR_TIMERTXT_DISABLE_FILTER="$TIMERTXT_DISABLE_FILTER"
OVR_TIMERTXT_VERBOSE="$TIMERTXT_VERBOSE"
OVR_TIMERTXT_DEFAULT_ACTION="$TIMERTXT_DEFAULT_ACTION"
OVR_TIMERTXT_SORT_COMMAND="$TIMERTXT_SORT_COMMAND"
OVR_TIMERTXT_FINAL_FILTER="$TIMERTXT_FINAL_FILTER"

# == PROCESS OPTIONS ==
while getopts ":fhpcnNaAtTvVx+@Pd:" Option
do
  case $Option in
    '@' )
        ## HIDE_CONTEXT_NAMES starts at zero (false); increment it to one
        ##   (true) the first time this flag is seen. Each time the flag
        ##   is seen after that, increment it again so that an even
        ##   number shows context names and an odd number hides context
        ##   names.
        : $(( HIDE_CONTEXT_NAMES++ ))
        if [ $(( $HIDE_CONTEXT_NAMES % 2 )) -eq 0 ]
        then
            ## Zero or even value -- show context names
            unset HIDE_CONTEXTS_SUBSTITUTION
        else
            ## One or odd value -- hide context names
            export HIDE_CONTEXTS_SUBSTITUTION='[[:space:]]@[[:graph:]]\{1,\}'
        fi
        ;;
    '+' )
        ## HIDE_PROJECT_NAMES starts at zero (false); increment it to one
        ##   (true) the first time this flag is seen. Each time the flag
        ##   is seen after that, increment it again so that an even
        ##   number shows project names and an odd number hides project
        ##   names.
        : $(( HIDE_PROJECT_NAMES++ ))
        if [ $(( $HIDE_PROJECT_NAMES % 2 )) -eq 0 ]
        then
            ## Zero or even value -- show project names
            unset HIDE_PROJECTS_SUBSTITUTION
        else
            ## One or odd value -- hide project names
            export HIDE_PROJECTS_SUBSTITUTION='[[:space:]][+][[:graph:]]\{1,\}'
        fi
        ;;
    a )
        OVR_TIMERTXT_AUTO_ARCHIVE=0
        ;;
    A )
        OVR_TIMERTXT_AUTO_ARCHIVE=1
        ;;
    c )
        OVR_TIMERTXT_PLAIN=0
        ;;
    d )
        TIMERTXT_CFG_FILE=$OPTARG
        ;;
    f )
        OVR_TIMERTXT_FORCE=1
        ;;
    h )
        # Short-circuit option parsing and forward to the action.
        # Cannot just invoke shorthelp() because we need the configuration
        # processed to locate the add-on actions directory.
        set -- '-h' 'shorthelp'
        ;;
    n )
        OVR_TIMERTXT_PRESERVE_LINE_NUMBERS=0
        ;;
    N )
        OVR_TIMERTXT_PRESERVE_LINE_NUMBERS=1
        ;;
    p )
        OVR_TIMERTXT_PLAIN=1
        ;;
    P )
        ## HIDE_PRIORITY_LABELS starts at zero (false); increment it to one
        ##   (true) the first time this flag is seen. Each time the flag
        ##   is seen after that, increment it again so that an even
        ##   number shows priority labels and an odd number hides priority
        ##   labels.
        : $(( HIDE_PRIORITY_LABELS++ ))
        if [ $(( $HIDE_PRIORITY_LABELS % 2 )) -eq 0 ]
        then
            ## Zero or even value -- show priority labels
            unset HIDE_PRIORITY_SUBSTITUTION
        else
            ## One or odd value -- hide priority labels
            export HIDE_PRIORITY_SUBSTITUTION="([A-Z])[[:space:]]"
        fi
        ;;
    t )
        OVR_TIMERTXT_DATE_ON_ADD=1
        ;;
    T )
        OVR_TIMERTXT_DATE_ON_ADD=0
        ;;
    v )
        : $(( TIMERTXT_VERBOSE++ ))
        ;;
    V )
        version
        ;;
    x )
        OVR_TIMERTXT_DISABLE_FILTER=1
        ;;
  esac
done
shift $(($OPTIND - 1))

# defaults if not yet defined
TIMERTXT_VERBOSE=${TIMERTXT_VERBOSE:-1}
TIMERTXT_PLAIN=${TIMERTXT_PLAIN:-0}
TIMERTXT_CFG_FILE=${TIMERTXT_CFG_FILE:-$HOME/.timer/config}
TIMERTXT_FORCE=${TIMERTXT_FORCE:-0}
TIMERTXT_PRESERVE_LINE_NUMBERS=${TIMERTXT_PRESERVE_LINE_NUMBERS:-1}
TIMERTXT_AUTO_ARCHIVE=${TIMERTXT_AUTO_ARCHIVE:-1}
TIMERTXT_DATE_ON_ADD=${TIMERTXT_DATE_ON_ADD:-0}
TIMERTXT_DEFAULT_ACTION=${TIMERTXT_DEFAULT_ACTION:-}
TIMERTXT_SORT_COMMAND=${TIMERTXT_SORT_COMMAND:-env LC_COLLATE=C sort -f -k2}
TIMERTXT_DISABLE_FILTER=${TIMERTXT_DISABLE_FILTER:-}
TIMERTXT_FINAL_FILTER=${TIMERTXT_FINAL_FILTER:-cat}

# Export all TIMERTXT_* variables
export ${!TIMERTXT_@}

# Default color map
export NONE=''
export BLACK='\\033[0;30m'
export RED='\\033[0;31m'
export GREEN='\\033[0;32m'
export BROWN='\\033[0;33m'
export BLUE='\\033[0;34m'
export PURPLE='\\033[0;35m'
export CYAN='\\033[0;36m'
export LIGHT_GREY='\\033[0;37m'
export DARK_GREY='\\033[1;30m'
export LIGHT_RED='\\033[1;31m'
export LIGHT_GREEN='\\033[1;32m'
export YELLOW='\\033[1;33m'
export LIGHT_BLUE='\\033[1;34m'
export LIGHT_PURPLE='\\033[1;35m'
export LIGHT_CYAN='\\033[1;36m'
export WHITE='\\033[1;37m'
export DEFAULT='\\033[0m'

# Default priority->color map.
export PRI_A=$YELLOW        # color for A priority
export PRI_B=$GREEN         # color for B priority
export PRI_C=$LIGHT_BLUE    # color for C priority
export PRI_X=$WHITE         # color unless explicitly defined

# Default highlight colors.
export COLOR_DONE=$LIGHT_GREY   # color for done (but not yet archived) tasks

# Default sentence delimiters for timer.sh append.
# If the text to be appended to the task begins with one of these characters, no
# whitespace is inserted in between. This makes appending to an enumeration
# (timer.sh add 42 ", foo") syntactically correct.
export SENTENCE_DELIMITERS=',.:;'

[ -e "$TIMERTXT_CFG_FILE" ] || {
    CFG_FILE_ALT="$HOME/timer.cfg"

    if [ -e "$CFG_FILE_ALT" ]
    then
        TIMERTXT_CFG_FILE="$CFG_FILE_ALT"
    fi
}

[ -e "$TIMERTXT_CFG_FILE" ] || {
    CFG_FILE_ALT="$HOME/.timer.cfg"

    if [ -e "$CFG_FILE_ALT" ]
    then
        TIMERTXT_CFG_FILE="$CFG_FILE_ALT"
    fi
}

[ -e "$TIMERTXT_CFG_FILE" ] || {
    CFG_FILE_ALT=$(dirname "$0")"/timer.cfg"

    if [ -e "$CFG_FILE_ALT" ]
    then
        TIMERTXT_CFG_FILE="$CFG_FILE_ALT"
    fi
}


if [ -z "$TIMER_ACTIONS_DIR" -o ! -d "$TIMER_ACTIONS_DIR" ]
then
    TIMER_ACTIONS_DIR="$HOME/.timer/actions"
    export TIMER_ACTIONS_DIR
fi

[ -d "$TIMER_ACTIONS_DIR" ] || {
    TIMER_ACTIONS_DIR_ALT="$HOME/.timer.actions.d"

    if [ -d "$TIMER_ACTIONS_DIR_ALT" ]
    then
        TIMER_ACTIONS_DIR="$TIMER_ACTIONS_DIR_ALT"
    fi
}

# === SANITY CHECKS (thanks Karl!) ===
[ -r "$TIMERTXT_CFG_FILE" ] || die "Fatal Error: Cannot read configuration file $TIMERTXT_CFG_FILE"

echo "$TIMERTXT_CFG_FILE"
. "$TIMERTXT_CFG_FILE"

# === APPLY OVERRIDES
if [ -n "$OVR_TIMERTXT_AUTO_ARCHIVE" ] ; then
  TIMERTXT_AUTO_ARCHIVE="$OVR_TIMERTXT_AUTO_ARCHIVE"
fi
if [ -n "$OVR_TIMERTXT_FORCE" ] ; then
  TIMERTXT_FORCE="$OVR_TIMERTXT_FORCE"
fi
if [ -n "$OVR_TIMERTXT_PRESERVE_LINE_NUMBERS" ] ; then
  TIMERTXT_PRESERVE_LINE_NUMBERS="$OVR_TIMERTXT_PRESERVE_LINE_NUMBERS"
fi
if [ -n "$OVR_TIMERTXT_PLAIN" ] ; then
  TIMERTXT_PLAIN="$OVR_TIMERTXT_PLAIN"
fi
if [ -n "$OVR_TIMERTXT_DATE_ON_ADD" ] ; then
  TIMERTXT_DATE_ON_ADD="$OVR_TIMERTXT_DATE_ON_ADD"
fi
if [ -n "$OVR_TIMERTXT_DISABLE_FILTER" ] ; then
  TIMERTXT_DISABLE_FILTER="$OVR_TIMERTXT_DISABLE_FILTER"
fi
if [ -n "$OVR_TIMERTXT_VERBOSE" ] ; then
  TIMERTXT_VERBOSE="$OVR_TIMERTXT_VERBOSE"
fi
if [ -n "$OVR_TIMERTXT_DEFAULT_ACTION" ] ; then
  TIMERTXT_DEFAULT_ACTION="$OVR_TIMERTXT_DEFAULT_ACTION"
fi
if [ -n "$OVR_TIMERTXT_SORT_COMMAND" ] ; then
  TIMERTXT_SORT_COMMAND="$OVR_TIMERTXT_SORT_COMMAND"
fi
if [ -n "$OVR_TIMERTXT_FINAL_FILTER" ] ; then
  TIMERTXT_FINAL_FILTER="$OVR_TIMERTXT_FINAL_FILTER"
fi

ACTION=${1:-$TIMERTXT_DEFAULT_ACTION}

[ -z "$ACTION" ]    && usage
[ -d "$TIMER_DIR" ]  || die "Fatal Error: $TIMER_DIR is not a directory"
( cd "$TIMER_DIR" )  || die "Fatal Error: Unable to cd to $TIMER_DIR"

[ -f "$TIMER_FILE" ] || cp /dev/null "$TIMER_FILE"
[ -f "$DONE_FILE" ] || cp /dev/null "$DONE_FILE"
[ -f "$REPORT_FILE" ] || cp /dev/null "$REPORT_FILE"

if [ $TIMERTXT_PLAIN = 1 ]; then
    for clr in ${!PRI_@}; do
        export $clr=$NONE
    done
    PRI_X=$NONE
    DEFAULT=$NONE
    COLOR_DONE=$NONE
fi

_addto() {
    file="$1"
    echo "file: $file"
    input="$2"
    echo "input: $input"
    cleaninput

    if [[ $TIMERTXT_DATE_ON_ADD = 1 ]]; then
        now=$(date '+%Y-%m-%d')
        input=$(echo "$input" | sed -e 's/^\(([A-Z]) \)\{0,1\}/\1'"$now /")
    fi
    echo "$input" >> "$file"
    if [ $TIMERTXT_VERBOSE -gt 0 ]; then
        TASKNUM=$(sed -n '$ =' "$file")
        echo "$TASKNUM $input"
        echo "$(getPrefix "$file"): $TASKNUM added."
    fi
}

shellquote()
{
    typeset -r qq=\'; printf %s\\n "'${1//\'/${qq}\\${qq}${qq}}'";
}

filtercommand()
{
    filter=${1:-}
    shift
    post_filter=${1:-}
    shift

    for search_term
    do
        ## See if the first character of $search_term is a dash
        if [ "${search_term:0:1}" != '-' ]
        then
            ## First character isn't a dash: hide lines that don't match
            ## this $search_term
            filter="${filter:-}${filter:+ | }grep -i $(shellquote "$search_term")"
        else
            ## First character is a dash: hide lines that match this
            ## $search_term
            #
            ## Remove the first character (-) before adding to our filter command
            filter="${filter:-}${filter:+ | }grep -v -i $(shellquote "${search_term:1}")"
        fi
    done

    [ -n "$post_filter" ] && {
        filter="${filter:-}${filter:+ | }${post_filter:-}"
    }

    printf %s "$filter"
}

_list() {
    local FILE="$1"
    ## If the file starts with a "/" use absolute path. Otherwise,
    ## try to find it in either $TIMER_DIR or using a relative path
    if [ "${1:0:1}" == / ]; then
        ## Absolute path
        src="$FILE"
    elif [ -f "$TIMER_DIR/$FILE" ]; then
        ## Path relative to timer.sh directory
        src="$TIMER_DIR/$FILE"
    elif [ -f "$FILE" ]; then
        ## Path relative to current working directory
        src="$FILE"
    elif [ -f "$TIMER_DIR/${FILE}.txt" ]; then
        ## Path relative to timer.sh directory, missing file extension
        src="$TIMER_DIR/${FILE}.txt"
    else
        die "TIMER: File $FILE does not exist."
    fi

    ## Get our search arguments, if any
    shift ## was file name, new $1 is first search term

    _format "$src" '' "$@"

    if [ $TIMERTXT_VERBOSE -gt 0 ]; then
        echo "--"
        echo "$(getPrefix "$src"): ${NUMTASKS:-0} of ${TOTALTASKS:-0} tasks shown"
    fi
}
getPadding()
{
    ## We need one level of padding for each power of 10 $LINES uses.
    LINES=$(sed -n '$ =' "${1:-$TIMER_FILE}")
    printf %s ${#LINES}
}
_format()
{
    # Parameters:    $1: timer input file; when empty formats stdin
    #                $2: ITEM# number width; if empty auto-detects from $1 / $TIMER_FILE.
    # Precondition:  None
    # Postcondition: $NUMTASKS and $TOTALTASKS contain statistics (unless $TIMERTXT_VERBOSE=0).

    FILE=$1
    shift

    ## Figure out how much padding we need to use, unless this was passed to us.
    PADDING=${1:-$(getPadding "$FILE")}
    shift

    ## Number the file, then run the filter command,
    ## then sort and mangle output some more
    if [[ $TIMERTXT_DISABLE_FILTER = 1 ]]; then
        TIMERTXT_FINAL_FILTER="cat"
    fi
    items=$(
        if [ "$FILE" ]; then
            sed = "$FILE"
        else
            sed =
        fi                                                      \
        | sed -e '''
            N
            s/^/     /
            s/ *\([ 0-9]\{'"$PADDING"',\}\)\n/\1 /
            /^[ 0-9]\{1,\} *$/d
         '''
    )

    ## Build and apply the filter.
    filter_command=$(filtercommand "${pre_filter_command:-}" "${post_filter_command:-}" "$@")
    if [ "${filter_command}" ]; then
        filtered_items=$(echo -n "$items" | eval "${filter_command}")
    else
        filtered_items=$items
    fi
    filtered_items=$(
        echo -n "$filtered_items"                              \
        | sed '''
            s/^     /00000/;
            s/^    /0000/;
            s/^   /000/;
            s/^  /00/;
            s/^ /0/;
          ''' \
        | eval ${TIMERTXT_SORT_COMMAND}                                        \
        | awk '''
            function highlight(colorVar,      color) {
                color = ENVIRON[colorVar]
                gsub(/\\+033/, "\033", color)
                return color
            }
            {
                if (match($0, /^[0-9]+ x /)) {
                    print highlight("COLOR_DONE") $0 highlight("DEFAULT")
                } else if (match($0, /^[0-9]+ \([A-Z]\) /)) {
                    clr = highlight("PRI_" substr($0, RSTART + RLENGTH - 3, 1))
                    print \
                        (clr ? clr : highlight("PRI_X")) \
                        (ENVIRON["HIDE_PRIORITY_SUBSTITUTION"] == "" ? $0 : substr($0, 1, RLENGTH - 4) substr($0, RSTART + RLENGTH)) \
                        highlight("DEFAULT")
                } else { print }
            }
          '''  \
        | sed '''
            s/'"${HIDE_PROJECTS_SUBSTITUTION:-^}"'//g
            s/'"${HIDE_CONTEXTS_SUBSTITUTION:-^}"'//g
            s/'"${HIDE_CUSTOM_SUBSTITUTION:-^}"'//g
          '''                                                   \
        | eval ${TIMERTXT_FINAL_FILTER}                          \
    )
    [ "$filtered_items" ] && echo "$filtered_items"

    if [ $TIMERTXT_VERBOSE -gt 0 ]; then
        NUMTASKS=$( echo -n "$filtered_items" | sed -n '$ =' )
        TOTALTASKS=$( echo -n "$items" | sed -n '$ =' )
    fi
    if [ $TIMERTXT_VERBOSE -gt 1 ]; then
        echo "TIMER DEBUG: Filter Command was: ${filter_command:-cat}"
    fi
}

export -f cleaninput getPrefix gettimer getNewtimer shellquote filtercommand _list getPadding _format die

# == HANDLE ACTION ==
action=$( printf "%s\n" "$ACTION" | tr 'A-Z' 'a-z' )

## If the first argument is "command", run the rest of the arguments
## using timer.sh builtins.
## Else, run a actions script with the name of the command if it exists
## or fallback to using a builtin
if [ "$action" == command ]
then
    ## Get rid of "command" from arguments list
    shift
    ## Reset action to new first argument
    action=$( printf "%s\n" "$1" | tr 'A-Z' 'a-z' )
elif [ -d "$TIMER_ACTIONS_DIR" -a -x "$TIMER_ACTIONS_DIR/$action" ]
then
    "$TIMER_ACTIONS_DIR/$action" "$@"
    exit $?
fi

## Only run if $action isn't found in .timer.actions.d
case $action in
"add" | "a" | "happy")
   echo 'line 887' 
    if [[ -z "$2" && $TIMERTXT_FORCE = 0 ]]; then
        echo -n "Add: "
        read input
    else
        [ -z "$2" ] && die "usage: $TIMER_SH add \"TIMER ITEM\""
        shift
        input=$*
    fi
  echo $PWD
$OFER_DIR/timer.sh $1 $2 $3

    _addto "$TIMER_FILE" "$input"
    ;;

"addm")
    if [[ -z "$2" && $TIMERTXT_FORCE = 0 ]]; then
        echo -n "Add: "
        read input
    else
        [ -z "$2" ] && die "usage: $TIMER_SH addm \"TIMER ITEM\""
        shift
        input=$*
    fi

    # Set Internal Field Seperator as newline so we can 
    # loop across multiple lines
    SAVEIFS=$IFS
    IFS=$'\n'

    # Treat each line seperately
    for line in $input ; do
        _addto "$TIMER_FILE" "$line"
    done
    IFS=$SAVEIFS
    ;;

"addto" )
    [ -z "$2" ] && die "usage: $TIMER_SH addto DEST \"TIMER ITEM\""
    dest="$TIMER_DIR/$2"
    [ -z "$3" ] && die "usage: $TIMER_SH addto DEST \"TIMER ITEM\""
    shift
    shift
    input=$*

    if [ -f "$dest" ]; then
        _addto "$dest" "$input"
    else
        die "TIMER: Destination file $dest does not exist."
    fi
    ;;

"append" | "app" )
    errmsg="usage: $TIMER_SH append ITEM# \"TEXT TO APPEND\""
    shift; item=$1; shift
    gettimer "$item"

    if [[ -z "$1" && $TIMERTXT_FORCE = 0 ]]; then
        echo -n "Append: "
        read input
    else
        input=$*
    fi
    case "$input" in
      [$SENTENCE_DELIMITERS]*)  appendspace=;;
      *)                        appendspace=" ";;
    esac
    cleaninput "for sed"

    if sed -i.bak $item" s|^.*|&${appendspace}${input}|" "$TIMER_FILE"; then
        if [ $TIMERTXT_VERBOSE -gt 0 ]; then
            getNewtimer "$item"
            echo "$item $newtimer"
	fi
    else
        die "TIMER: Error appending task $item."
    fi
    ;;

"archive" )
    # defragment blank lines
    sed -i.bak -e '/./!d' "$TIMER_FILE"
    [ $TIMERTXT_VERBOSE -gt 0 ] && grep "^x " "$TIMER_FILE"
    grep "^x " "$TIMER_FILE" >> "$DONE_FILE"
    sed -i.bak '/^x /d' "$TIMER_FILE"
    if [ $TIMERTXT_VERBOSE -gt 0 ]; then
	echo "TIMER: $TIMER_FILE archived."
    fi
    ;;

"del" | "rm" )
    # replace deleted line with a blank line when TIMERTXT_PRESERVE_LINE_NUMBERS is 1
    errmsg="usage: $TIMER_SH del ITEM# [TERM]"
    item=$2
    gettimer "$item"

    if [ -z "$3" ]; then
        if  [ $TIMERTXT_FORCE = 0 ]; then
            echo "Delete '$timer'?  (y/n)"
            read ANSWER
        else
            ANSWER="y"
        fi
        if [ "$ANSWER" = "y" ]; then
            if [ $TIMERTXT_PRESERVE_LINE_NUMBERS = 0 ]; then
                # delete line (changes line numbers)
                sed -i.bak -e $item"s/^.*//" -e '/./!d' "$TIMER_FILE"
            else
                # leave blank line behind (preserves line numbers)
                sed -i.bak -e $item"s/^.*//" "$TIMER_FILE"
            fi
            if [ $TIMERTXT_VERBOSE -gt 0 ]; then
                echo "$item $timer"
                echo "TIMER: $item deleted."
            fi
        else
            echo "TIMER: No tasks were deleted."
        fi
    else
        sed -i.bak \
            -e $item"s/^\((.) \)\{0,1\} *$3 */\1/g" \
            -e $item"s/ *$3 *\$//g" \
            -e $item"s/  *$3 */ /g" \
            -e $item"s/ *$3  */ /g" \
            -e $item"s/$3//g" \
            "$TIMER_FILE"
        getNewtimer "$item"
        if [ "$timer" = "$newtimer" ]; then
            [ $TIMERTXT_VERBOSE -gt 0 ] && echo "$item $timer"
            die "TIMER: '$3' not found; no removal done."
        fi
        if [ $TIMERTXT_VERBOSE -gt 0 ]; then
            echo "$item $timer"
            echo "TIMER: Removed '$3' from task."
            echo "$item $newtimer"
        fi
    fi
    ;;

"depri" | "dp" )
    errmsg="usage: $TIMER_SH depri ITEM#[, ITEM#, ITEM#, ...]"
    shift;
    [ $# -eq 0 ] && die "$errmsg"

    # Split multiple depri's, if comma separated change to whitespace separated
    # Loop the 'depri' function for each item
    for item in ${*//,/ }; do
        gettimer "$item"

	if [[ "$timer" = \(?\)\ * ]]; then
	    sed -i.bak -e $item"s/^(.) //" "$TIMER_FILE"
	    if [ $TIMERTXT_VERBOSE -gt 0 ]; then
		getNewtimer "$item"
		echo "$item $newtimer"
		echo "TIMER: $item deprioritized."
	    fi
	else
	    echo "TIMER: $item is not prioritized."
	fi
    done
    ;;

"do" )
    errmsg="usage: $TIMER_SH do ITEM#[, ITEM#, ITEM#, ...]"
    # shift so we get arguments to the do request
    shift;
    [ "$#" -eq 0 ] && die "$errmsg"

    # Split multiple do's, if comma separated change to whitespace separated
    # Loop the 'do' function for each item
    for item in ${*//,/ }; do
        gettimer "$item"

        # Check if this item has already been done
        if [ "${timer:0:2}" != "x " ]; then
            now=$(date '+%Y-%m-%d')
            # remove priority once item is done
            sed -i.bak $item"s/^(.) //" "$TIMER_FILE"
            sed -i.bak $item"s|^|x $now |" "$TIMER_FILE"
            if [ $TIMERTXT_VERBOSE -gt 0 ]; then
                getNewtimer "$item"
                echo "$item $newtimer"
                echo "TIMER: $item marked as done."
	    fi
        else
            echo "TIMER: $item is already marked done."
        fi
    done

    if [ $TIMERTXT_AUTO_ARCHIVE = 1 ]; then
        # Recursively invoke the script to allow overriding of the archive
        # action.
        "$TIMER_FULL_SH" archive
    fi
    ;;

"help" )
    if [ -t 1 ] ; then # STDOUT is a TTY
        if which "${PAGER:-less}" >/dev/null 2>&1; then
            # we have a working PAGER (or less as a default)
            help | "${PAGER:-less}" && exit 0
        fi
    fi
    help # just in case something failed above, we go ahead and just spew to STDOUT
    ;;

"shorthelp" )
    if [ -t 1 ] ; then # STDOUT is a TTY
        if which "${PAGER:-less}" >/dev/null 2>&1; then
            # we have a working PAGER (or less as a default)
            shorthelp | "${PAGER:-less}" && exit 0
        fi
    fi
    shorthelp # just in case something failed above, we go ahead and just spew to STDOUT
    ;;

"list" | "ls" )
    shift  ## Was ls; new $1 is first search term
    _list "$TIMER_FILE" "$@"
    ;;

"listall" | "lsa" )
    shift  ## Was lsa; new $1 is first search term

    TOTAL=$( sed -n '$ =' "$TIMER_FILE" )
    PADDING=${#TOTAL}

    post_filter_command="awk -v TOTAL=$TOTAL -v PADDING=$PADDING '{ \$1 = sprintf(\"%\" PADDING \"d\", (\$1 > TOTAL ? 0 : \$1)); print }' "
    cat "$TIMER_FILE" "$DONE_FILE" | TIMERTXT_VERBOSE=0 _format '' "$PADDING" "$@"

    if [ $TIMERTXT_VERBOSE -gt 0 ]; then
        TDONE=$( sed -n '$ =' "$DONE_FILE" )
        TASKNUM=$(TIMERTXT_PLAIN=1 TIMERTXT_VERBOSE=0 _format "$TIMER_FILE" 1 "$@" | sed -n '$ =')
        DONENUM=$(TIMERTXT_PLAIN=1 TIMERTXT_VERBOSE=0 _format "$DONE_FILE" 1 "$@" | sed -n '$ =')
        echo "--"
        echo "$(getPrefix "$TIMER_FILE"): ${TASKNUM:-0} of ${TOTAL:-0} tasks shown"
        echo "$(getPrefix "$DONE_FILE"): ${DONENUM:-0} of ${TDONE:-0} tasks shown"
        echo "total $((TASKNUM + DONENUM)) of $((TOTAL + TDONE)) tasks shown"
    fi
    ;;

"listfile" | "lf" )
    shift  ## Was listfile, next $1 is file name
    if [ $# -eq 0 ]; then
        [ $TIMERTXT_VERBOSE -gt 0 ] && echo "Files in the timer.txt directory:"
        cd "$TIMER_DIR" && ls -1 *.txt
    else
        FILE="$1"
        shift  ## Was filename; next $1 is first search term

        _list "$FILE" "$@"
    fi
    ;;

"listcon" | "lsc" )
    FILE=$TIMER_FILE
    [ "$TIMERTXT_SOURCEVAR" ] && eval "FILE=$TIMERTXT_SOURCEVAR"
    grep -ho '[^ ]*@[^ ]\+' "${FILE[@]}" | grep '^@' | sort -u
    ;;

"listproj" | "lsprj" )
    FILE=$TIMER_FILE
    [ "$TIMERTXT_SOURCEVAR" ] && eval "FILE=$TIMERTXT_SOURCEVAR"
    shift
    eval "$(filtercommand 'cat "${FILE[@]}"' '' "$@")" | grep -o '[^ ]*+[^ ]\+' | grep '^+' | sort -u
    ;;

"listpri" | "lsp" )
    shift ## was "listpri", new $1 is priority to list or first TERM

    pri=$(printf "%s\n" "$1" | tr 'a-z' 'A-Z' | grep -e '^[A-Z]$' -e '^[A-Z]-[A-Z]$') && shift || pri="A-Z"
    post_filter_command="grep '^ *[0-9]\+ ([${pri}]) '"
    _list "$TIMER_FILE" "$@"
    ;;

"move" | "mv" )
    # replace moved line with a blank line when TIMERTXT_PRESERVE_LINE_NUMBERS is 1
    errmsg="usage: $TIMER_SH mv ITEM# DEST [SRC]"
    item=$2
    dest="$TIMER_DIR/$3"
    src="$TIMER_DIR/$4"

    [ -z "$4" ] && src="$TIMER_FILE"
    [ -z "$dest" ] && die "$errmsg"

    [ -f "$src" ] || die "TIMER: Source file $src does not exist."
    [ -f "$dest" ] || die "TIMER: Destination file $dest does not exist."

    gettimer "$item" "$src"
    [ -z "$timer" ] && die "$item: No such item in $src."
    if  [ $TIMERTXT_FORCE = 0 ]; then
        echo "Move '$timer' from $src to $dest? (y/n)"
        read ANSWER
    else
        ANSWER="y"
    fi
    if [ "$ANSWER" = "y" ]; then
        if [ $TIMERTXT_PRESERVE_LINE_NUMBERS = 0 ]; then
            # delete line (changes line numbers)
            sed -i.bak -e $item"s/^.*//" -e '/./!d' "$src"
        else
            # leave blank line behind (preserves line numbers)
            sed -i.bak -e $item"s/^.*//" "$src"
        fi
        echo "$timer" >> "$dest"

        if [ $TIMERTXT_VERBOSE -gt 0 ]; then
            echo "$item $timer"
            echo "TIMER: $item moved from '$src' to '$dest'."
        fi
    else
        echo "TIMER: No tasks moved."
    fi
    ;;

"prepend" | "prep" )
    errmsg="usage: $TIMER_SH prepend ITEM# \"TEXT TO PREPEND\""
    replaceOrPrepend 'prepend' "$@"
    ;;

"pri" | "p" )
    item=$2
    newpri=$( printf "%s\n" "$3" | tr 'a-z' 'A-Z' )

    errmsg="usage: $TIMER_SH pri ITEM# PRIORITY
note: PRIORITY must be anywhere from A to Z."

    [ "$#" -ne 3 ] && die "$errmsg"
    [[ "$newpri" = @([A-Z]) ]] || die "$errmsg"
    gettimer "$item"

    oldpri=
    if [[ "$timer" = \(?\)\ * ]]; then
        oldpri=${timer:1:1}
    fi

    if [ "$oldpri" != "$newpri" ]; then
        sed -i.bak -e $item"s/^(.) //" -e $item"s/^/($newpri) /" "$TIMER_FILE"
    fi
    if [ $TIMERTXT_VERBOSE -gt 0 ]; then
        getNewtimer "$item"
        echo "$item $newtimer"
        if [ "$oldpri" != "$newpri" ]; then
            if [ "$oldpri" ]; then
                echo "TIMER: $item re-prioritized from ($oldpri) to ($newpri)."
            else
                echo "TIMER: $item prioritized ($newpri)."
            fi
        fi
    fi
    if [ "$oldpri" = "$newpri" ]; then
        echo "TIMER: $item already prioritized ($newpri)."
    fi
    ;;

"replace" )
    errmsg="usage: $TIMER_SH replace ITEM# \"UPDATED ITEM\""
    replaceOrPrepend 'replace' "$@"
    ;;

"report" )
    # archive first
    # Recursively invoke the script to allow overriding of the archive
    # action.
    "$TIMER_FULL_SH" archive

    TOTAL=$( sed -n '$ =' "$TIMER_FILE" )
    TDONE=$( sed -n '$ =' "$DONE_FILE" )
    NEWDATA="${TOTAL:-0} ${TDONE:-0}"
    LASTREPORT=$(sed -ne '$p' "$REPORT_FILE")
    LASTDATA=${LASTREPORT#* }   # Strip timestamp.
    if [ "$LASTDATA" = "$NEWDATA" ]; then
        echo "$LASTREPORT"
        [ $TIMERTXT_VERBOSE -gt 0 ] && echo "TIMER: Report file is up-to-date."
    else
        NEWREPORT="$(date +%Y-%m-%dT%T) ${NEWDATA}"
        echo "${NEWREPORT}" >> "$REPORT_FILE"
        echo "${NEWREPORT}"
        [ $TIMERTXT_VERBOSE -gt 0 ] && echo "TIMER: Report file updated."
    fi
    ;;

"deduplicate" )
    if [ $TIMERTXT_PRESERVE_LINE_NUMBERS = 0 ]; then
        deduplicateSedCommand='d'
    else
        deduplicateSedCommand='s/^.*//; p'
    fi

    # To determine the difference when deduplicated lines are preserved, only
    # non-empty lines must be counted.
    originalTaskNum=$( sed -e '/./!d' "$TIMER_FILE" | sed -n '$ =' )

    # Look for duplicate lines and discard the second occurrence.
    # We start with an empty hold space on the first line.  For each line:
    #   G - appends newline + hold space to the pattern space
    #   s/\n/&&/; - double up the first new line so we catch adjacent dups
    #   /^\([^\n]*\n\).*\n\1/b dedup
    #       If the first line of the hold space shows up again later as an
    #       entire line, it's a duplicate. Jump to the "dedup" label, where
    #       either of the following is executed, depending on whether empty
    #       lines should be preserved:
    #       d           - Delete the current pattern space, quit this line and
    #                     move on to the next, or:
    #       s/^.*//; p  - Clear the task text, print this line and move on to
    #                     the next.
    #   s/\n//;   - else (no duplicate), drop the doubled newline
    #   h;        - replace the hold space with the expanded pattern space
    #   P;        - print up to the first newline (that is, the input line)
    #   b         - end processing of the current line
    sed -i.bak -n \
        -e 'G; s/\n/&&/; /^\([^\n]*\n\).*\n\1/b dedup' \
        -e 's/\n//; h; P; b' \
        -e ':dedup' \
        -e "$deduplicateSedCommand" \
        "$TIMER_FILE"

    newTaskNum=$( sed -e '/./!d' "$TIMER_FILE" | sed -n '$ =' )
    deduplicateNum=$(( originalTaskNum - newTaskNum ))
    if [ $deduplicateNum -eq 0 ]; then
        echo "TIMER: No duplicate tasks found"
    else
        echo "TIMER: $deduplicateNum duplicate task(s) removed"
    fi
    ;;

"listaddons" )
    if [ -d "$TIMER_ACTIONS_DIR" ]; then
        cd "$TIMER_ACTIONS_DIR" || exit $?
        for action in *
        do
            if [ -f "$action" -a -x "$action" ]; then
                echo "$action"
            fi
        done
    fi
    ;;

* )
    usage;;
esac

