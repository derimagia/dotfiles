#!/usr/bin/env zsh

# Color Arrays. Vital.
typeset -Ag FX FG BG
export FG BG FX
FX=(
    reset     "$terminfo[sgr0]"
    bold      "$terminfo[bold]"
    italic    "$terminfo[sitm]"  no-italic    "$terminfo[ritm]"
    underline "$terminfo[smul]"  no-underline "$terminfo[rmul]"
    blink     "$terminfo[blink]"
    reverse   "$terminfo[rev]"   no-reverse   "$terminfo[rum]"
    standout  "$terminfo[smso]"  no-standout  "$terminfo[rmso]"
)


for color in {0..255}; do
    FG[$color]="[38;5;${color}m"
    BG[$color]="[48;5;${color}m"
done

FG[none]=$FG[0];        BG[none]=$BG[0]
FG[darkred]=$FG[1];     BG[darkred]=$BG[1]
FG[darkgreen]=$FG[2];   BG[darkgreen]=$BG[2]
FG[darkyellow]=$FG[3];  BG[darkyellow]=$BG[3]
FG[darkblue]=$FG[4];    BG[darkblue]=$BG[4]
FG[darkmagenta]=$FG[5]; BG[darkmagenta]=$BG[5]
FG[darkcyan]=$FG[6];    BG[darkcyan]=$BG[6]
FG[grey]=$FG[7];        BG[grey]=$BG[7]
FG[darkgrey]=$FG[8];    BG[darkgrey]=$BG[8]
FG[red]=$FG[9];         BG[red]=$BG[9]
FG[green]=$FG[10];      BG[green]=$BG[10]
FG[yellow]=$FG[11];     BG[yellow]=$BG[11]
FG[blue]=$FG[12];       BG[blue]=$BG[12]
FG[magenta]=$FG[13];    BG[magenta]=$BG[13]
FG[cyan]=$FG[14];       BG[cyan]=$BG[14]
FG[lightgrey]=$FG[15];  BG[lightgrey]=$BG[15]
