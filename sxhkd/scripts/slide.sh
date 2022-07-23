#!/bin/sh

checkDependencies () {
	for dep; do
		if ! command -v "$dep" >/dev/null ; then
			log "Program \"$dep\" not found. Please install it."
		fi
	done
}

displayHelp () {
	while IFS= read -r line; do
		printf "%s\n" "$line"
	done <<-EOF
  
	Usage:
	  $prog [-c <command>] [-s <size>]
	Options:
	  -h show help
	  -c command to execute
	  -s size (defaut 80%, can be 1500x360)
	EOF
}

DEBUG=false
logfile="${XDG_CACHE_HOME:-$HOME/.cache}/slide_command"
function log {
    local MESSAGE="${@}"
    if [[ "${DEBUG}" == true ]];then
      echo "$(date) ${MESSAGE}"  >> $logfile
    fi
}

function defineIncrementFromSpeed() {
    increment=$(($height/80))
    log "increment for animation duration: $increment"
}

function readGeometry() {
    monitor=$(bspc query --monitors --monitor focused --names)

    geometryPattern="^.*: ([0-9]*)x([0-9]*)\+([0-9]*)\+([0-9]*)"
    [[ $(polybar --list-monitors | grep $monitor) =~ $geometryPattern ]]
    monitorWidth=${BASH_REMATCH[1]}
    monitorHeight=${BASH_REMATCH[2]}
    x=${BASH_REMATCH[3]}
    y=${BASH_REMATCH[4]}
    
    log "${BASH_REMATCH[0]}"
}

function defineWindowSize() {
    if [[ $size =~ ^([0-9]*)x([0-9]*)$ ]]; then
        log "size geometry pattern"
        width=${BASH_REMATCH[1]}
        height=${BASH_REMATCH[2]}

    elif [[ $size =~ ^([0-9]{1,3})%?$ ]]; then
        log "size percent pattern"
        percent=${BASH_REMATCH[1]}
        width=$(bc -l <<< "scale = 0; $monitorWidth*$percent/100")
        height=$(bc -l <<< "scale = 0; $monitorHeight*$percent/100")

    else
        log "fullscreen size"
        width=$monitorWidth
        height=$monitorHeight
    fi

    x=$(($x + ($monitorWidth - $width) / 2))

    log "monitor=$monitor, window geometry: width=$width|height=$height|x=$x|y=$y"
}

function readWid() {
    slidePid=$(xdotool search $1 --class "$class")
    wid=$(xwininfo -root -children | grep "$class" | awk '{print $1}')
    log "wid=$wid"
}

function createWindow() {
    log "creating windows..."

    read prog args <<< "$command"

    log "launching command: $prog --class $class,$class $args"
    bspc rule -a $class -o state=$state hidden=on border=off \
        && $prog --class $class,$class $args \
        && bspc rule --remove $class &

    readWid --sync
    xdotool windowsize $wid $width $height
    
    # hide
    xdotool windowmove $wid $x -$height
    bspc node $wid --flag hidden=off
}

function setUp() {
    readWid
    readGeometry
    defineWindowSize
    defineIncrementFromSpeed
}

function show() {
    log "sliding down..."
    bspc node $wid --to-desktop focused:focused
    top=-$monitorHeight
    until [ $top -gt 0 ]; do
        xdotool windowmove $wid $x $top
        top=$((top+$increment))
    done
    xdotool windowmove $wid $x 0
    bspc node $wid --focus
}

function hide() {
    log "sliding up..."
    top=0
    until [ $top -lt -$monitorHeight ]; do
        xdotool windowmove $wid $x $top
        ((top=top-$increment))
    done
    xdotool windowmove $wid $x -$monitorHeight
    bspc node $wid --focus
}

function toggleShowHide() {
    initial=$(xdotool getwindowgeometry $wid | grep Position)
    [[ $initial =~ ([0-9])*,([0-9])* ]]
    initialX=${BASH_REMATCH[1]}
    initialY=${BASH_REMATCH[2]}

    if [[ $initialY -lt 0 || "$initialY" == "" ]];then
        show
    else
        hide
    fi
}

log "--------------------"
checkDependencies "bspc" "xdotool" "xwininfo" "bc" "polybar" "awk" "grep"

prog=$0
command=alacritty
size="80%"

while getopts h:c:s: option
do 
    case "${option}"
        in
        h)displayHelp; exit 0;;
        c)command=${OPTARG};;
        s)size=${OPTARG};;
        *)displayHelp; exit 1;;
    esac
done

class="slide-$(echo $command | base64)"
state=floating

setUp

if [[ -z "$wid" ]]; then
    createWindow
fi
toggleShowHide
