# --- make MacOs more compatible with GNU Linux like WSL2 ---
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH" # prefer ggrep
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH" # prefer gsed
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" # prefer gnu coreutils

# --- my useful environment variables ---
CRLF=$'\r\n'
# ansi escape code colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
RESET='\033[0m' # No Color
# truecolor escape code colors
RED='\033[38;2;255;0;0m'
GREEN='\033[38;2;0;255;0m'
YELLOW='\033[38;2;255;255;0m'
BLUE='\033[38;2;0;0;255m'
MAGENTA='\033[38;2;255;0;255m'
CYAN='\033[38;2;0;255;255m'
GREY='\033[38;2;128;128;128m'
DKRED='\033[38;2;128;0;0m'
DKGREEN='\033[38;2;0;128;0m'
DKYELLOW='\033[38;2;128;128;0m'
DKBLUE='\033[38;2;0;0;128m'
DKMAGENTA='\033[38;2;128;0;128m'
DKCYAN='\033[38;2;0;128;128m'
DKGREY='\033[38;2;64;64;64m'
LTRED='\033[38;2;255;128;128m'
LTGREEN='\033[38;2;128;255;128m'
LTYELLOW='\033[38;2;255;255;128m'
LTBLUE='\033[38;2;128;128;255m'
LTMAGENTA='\033[38;2;255;128;255m'
LTCYAN='\033[38;2;128;255;255m'
LTGREY='\033[38;2;192;192;192m'
WHITE='\033[38;2;255;255;255m'

bar1="++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
bar1=$bar1$bar1
bar2="****************************************************************"
bar2=$bar2$bar2
bar3="################################################################"
bar3=$bar3$bar3
bar4=">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
bar4=$bar4$bar4
bar5="================================================================"
bar5=$bar5$bar5
# meter1="▁▂▃▄▅▆▇█"
# meter2="▏▎▍▌▋▊▉█"
border_upper_left_corner="┌"
border_upper_right_corner="┐"
border_lower_left_corner="└"
border_lower_right_corner="┘"
border_horizontal_line="─"
border_vertical_line="│"
border_cross="┼"
border_tee_up="┴"
border_tee_down="┬"
border_tee_left="┤"
border_tee_right="├"
border_thick_upper_left_corner="┏"
border_thick_upper_right_corner="┓"
border_thick_lower_left_corner="┗"
border_thick_lower_right_corner="┛"
border_thick_horizontal_line="━"
border_thick_vertical_line="┃"
border_thick_cross="╋"
border_thick_tee_up="┻"
border_thick_tee_down="┳"
border_thick_tee_left="┫"
border_thick_tee_right="┣"
border_doulbe_upper_left_corner="╔"
border_doulbe_upper_right_corner="╗"
border_doulbe_lower_left_corner="╚"
border_doulbe_lower_right_corner="╝"
border_doulbe_horizontal_line="═"
border_doulbe_vertical_line="║"
border_doulbe_cross="╬"
border_doulbe_tee_up="╩"
border_doulbe_tee_down="╦"
border_doulbe_tee_left="╣"
border_doulbe_tee_right="╠"

# Remind me to use all the colors every time I log in!
printf "${RED}red${RESET}/"
printf "${DKRED}dark red${RESET}/"
printf "${GREEN}green${RESET}/"
printf "${YELLOW}yellow${RESET}/"
printf "${BLUE}blue${RESET}/"
printf "${LTBLUE}light blue${RESET}/"
printf "${MAGENTA}magenta${RESET}/"
printf "${CYAN}cyan${RESET}/"
printf "${RESET}\n"
printf "${DKGREY}dark grey${RESET}/"
printf "${GREY}grey${RESET}/"
printf "${LTGREY}light grey${RESET}/"
printf "${RESET}\n"

# --- aliases ---
alias G='cd ~/GitHub; ls'
alias cfg='cd ~/.config; ls'
alias cat='bat'
alias b='bat'
alias cd='pushd'
alias pop='popd'
alias ls='ls -a -G --color=always'
alias ll='ls -l'

# --- my functions ---
timestamp() {
    date "+%s_%Y-%m-%d_%I:%M_%p"
}
LOGS=$HOME/GitHub/LOGS; [ -d $LOGS ] || mkdir -p $LOGS
function latest-log() {
    # $1=prefix $2=postfix $3=which where 1 is most recent 2 is 2nd most recent etc
    local prefix=$1
    local postfix=$2
    local which=${3:-1} # default to '1' which is most recent
    ls -t $LOGS/$prefix*$postfix | sed -n "${3:-1}p"
}
function c-log() {
    code $(latest-log $*)
}
function term_width() {
    echo $COLUMNS
    # NOTE: tried tput cols, but it gets capped at 80 columns
}
function back_from_eol() {
    local spaces=$((${1:-10} - 1))
    # get current cursor position and printf spaces equal to term_width - spaces - position
    printf "\033[6n" > /dev/tty
    tput sc
    tput hpa $(term_width)
    tput cub $spaces
}
function grep-all-logs() {
    local regex=${1:-Rebooting}
    local bar_len=${2:-64}
    local scale_down=${3:-1}
    # WARN: this fn only scans top level of $LOGS
    fd -d 1 monitor $LOGS | \
    xargs grep -a -c --color=never $regex | \
    sed 's/.ansi.txt/*.txt/' | sed 's/^.*monitor/*m*/' | \
    awk \
        -v scale=$scale_down \
        -v bar="${bar3:0:$bar_len}" \
        -v color="$YELLOW" \
        -v pos="$(back_from_eol $bar_len)" \
        -v nc="$RESET" \
        -F: \
        '!/:0$/ { \
            len = int(0.5+$NF/scale); \
            str = len ? substr(bar,0,len) : "|"; \
            printf "%s %s%s%s%s\n", $0, color, pos, str, nc; \
        }' | \
    sort --reverse
}
function diffp() {
    # derived from
    # git diff origin/main HEAD --stat | head -n -1 | fzf --height 100% --preview-window=up:36 --layout=reverse
    # --preview 'git diff -U0 --color=always origin -- ../$(echo {} | cut -d " " -f 2)' >/dev/null
    local branch_a=${1}
    local branch_b=${2}
    local preview_cmd="git diff -U0 --color=always ${branch_a} ${branch_b} -- ../\$(echo {} | cut -d \" \" -f 2)"

    git diff ${branch_a} ${branch_b} --stat --color=always | \
    head -n -1 | \
    sort -r -k 3 | \
    fzf \
        --prompt="Diff: ${branch_a} ${branch_b} > " \
        --ansi \
        --height 100% \
        --preview-window=up:36 \
        --layout=reverse \
        --preview ${preview_cmd} \
    >/dev/null
}

# --- started this secrets practice with MassMelt ---
source ~/.config/secrets/secrets.sh

# --- ESP-IDF
export IDF_PATH="$HOME/esp/v5.1.1/esp-idf"
idf-latest-log() {
    latest-log idf-monitor- .ansi.txt
}
alias get-idf='. $IDF_PATH/export.sh'
alias idf-flash='idf.py flash monitor 2>&1 | tee $LOGS/idf-monitor-$(timestamp).ansi.txt'
alias idf-monitor='idf.py monitor 2>&1 | tee $LOGS/idf-monitor-$(timestamp).ansi.txt'
alias idf-build='idf.py build'
alias idf-clean='idf.py fullclean'
alias idf-erase='esptool.py erase_region 0x5F0000 0x1D0000'
alias compile-commands='(cd build && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..)'
echo "Remember to run 'get-idf' to set up the ESP-IDF environment"
