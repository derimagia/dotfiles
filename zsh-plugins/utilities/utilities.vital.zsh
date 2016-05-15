#!/usr/bin/env zsh


# PLATFORM
export SHELL_PLATFORM='unknown'
ostype() { echo "$OSTYPE" | tr '[:upper:]' '[:lower:]'; }

case "$(ostype)" in
    *'linux'*) SHELL_PLATFORM='linux' ;;
    *'darwin'*) SHELL_PLATFORM='osx' ;;
esac

is_linux() { [[ $SHELL_PLATFORM == 'linux' || $SHELL_PLATFORM == 'bsd' ]]; }

is_osx() { [[ $SHELL_PLATFORM == 'osx' ]]; }

# General functions that should be loaded first

# Has Commands
has.{command,function,builtin,alias,galias}() {
    eval "(( $+${0/#has./}s[${1:?too few argument}] ))"
    return $status
}

has() {
    has.function "$1" ||  \
    has.command "$1" ||  \
    has.builtin "$1" ||  \
    has.alias "$1" ||  \
    has.galias "$1"

    return $status
}

# Global Aliases
alias -g __DIRECTORY__='${${(%):-%N}:A:h}' # Get Directory Script is in

is_login_shell() { [[ $SHLVL == 1 ]]; }

is_interactive_shell() { [ ! -z "$PS1" ]; }

is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

hasnt() { (! has "$1") }

allcolors() {
    has.command 'hr' && hr ' ' '-' ' '

    print -l '256 Colors\n'

    for x in 0 1 4 5 7 8; do
        for i in `seq 30 37`; do
            for a in `seq 40 47`; do
                echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
            done
            echo
        done
    done

    has.command 'hr' && hr ' ' '-' ' '

    print -l '256 Colors\n'

    for C in {0..255}; do
        tput setab $C
        echo -n "$C"
    done
    tput sgr0

    has.command 'hr' && hr ' ' '-' ' '

    print -l 'True Color Tests\n'

    setBackgroundColor()
    {
        printf '\x1b[48;2;%s;%s;%sm' $1 $2 $3
    }

    resetOutput()
    {
        echo -en "\x1b[0m\n"
    }

    # Gives a color $1/255 % along HSV
    # Who knows what happens when $1 is outside 0-255
    # Echoes "$red $green $blue" where
    # $red $green and $blue are integers
    # ranging between 0 and 255 inclusive
    rainbowColor()
    {
        let h="$1/43"
        let f="$1-43*$h"
        let t="$f*255/43"
        let q="255-t"

        if [ $h -eq 0 ]
        then
            echo "255 $t 0"
        elif [ $h -eq 1 ]
        then
            echo "$q 255 0"
        elif [ $h -eq 2 ]
        then
            echo "0 255 $t"
        elif [ $h -eq 3 ]
        then
            echo "0 $q 255"
        elif [ $h -eq 4 ]
        then
            echo "$t 0 255"
        elif [ $h -eq 5 ]
        then
            echo "255 0 $q"
        else
            # execution should never reach here
            echo "0 0 0"
        fi
    }

    for i in `seq 0 127`; do
        setBackgroundColor $i 0 0
        echo -en " "
    done
    resetOutput
    for i in `seq 255 -1 128`; do
        setBackgroundColor $i 0 0
        echo -en " "
    done
    resetOutput

    for i in `seq 0 127`; do
        setBackgroundColor 0 $i 0
        echo -n " "
    done
    resetOutput
    for i in `seq 255 -1 128`; do
        setBackgroundColor 0 $i 0
        echo -n " "
    done
    resetOutput

    for i in `seq 0 127`; do
        setBackgroundColor 0 0 $i
        echo -n " "
    done
    resetOutput
    for i in `seq 255 -1 128`; do
        setBackgroundColor 0 0 $i
        echo -n " "
    done
    resetOutput

    for i in `seq 0 127`; do
        setBackgroundColor `rainbowColor $i`
        echo -n " "
    done
    resetOutput
    for i in `seq 255 -1 128`; do
        setBackgroundColor `rainbowColor $i`
        echo -n " "
    done
    resetOutput

    has.command 'hr' && hr ' ' '-' ' '
}

# Autoload vitals
autoload -Uz add-zsh-hook
