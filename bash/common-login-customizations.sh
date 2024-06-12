# --- make MacOs more compatible with GNU Linux like WSL2 ---
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH" # prefer ggrep
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH" # prefer gsed
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" # prefer gnu coreutils

# --- my useful environment variables ---
export CRLF=$'\r\n'
# ansi escape code colors
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export MAGENTA='\033[0;35m'
export CYAN='\033[0;36m'
export RESET='\033[0m' # No Color
# truecolor escape code colors
export RED='\033[38;2;255;0;0m'
export GREEN='\033[38;2;0;255;0m'
export YELLOW='\033[38;2;255;255;0m'
export BLUE='\033[38;2;0;0;255m'
export MAGENTA='\033[38;2;255;0;255m'
export CYAN='\033[38;2;0;255;255m'
export GREY='\033[38;2;128;128;128m'
export DKRED='\033[38;2;128;0;0m'
export DKGREEN='\033[38;2;0;128;0m'
export DKYELLOW='\033[38;2;128;128;0m'
export DKBLUE='\033[38;2;0;0;128m'
export DKMAGENTA='\033[38;2;128;0;128m'
export DKCYAN='\033[38;2;0;128;128m'
export DKGREY='\033[38;2;64;64;64m'
export LTRED='\033[38;2;255;128;128m'
export LTGREEN='\033[38;2;128;255;128m'
export LTYELLOW='\033[38;2;255;255;128m'
export LTBLUE='\033[38;2;128;128;255m'
export LTMAGENTA='\033[38;2;255;128;255m'
export LTCYAN='\033[38;2;128;255;255m'
export LTGREY='\033[38;2;192;192;192m'
export WHITE='\033[38;2;255;255;255m'

export bar1="++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
export bar1=$bar1$bar1
export bar2="****************************************************************"
export bar2=$bar2$bar2
export bar3="################################################################"
export bar3=$bar3$bar3
export bar4=">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
export bar4=$bar4$bar4
export bar5="================================================================"
export bar5=$bar5$bar5
# meter1="▁▂▃▄▅▆▇█"
# meter2="▏▎▍▌▋▊▉█"
export border_upper_left_corner="┌"
export border_upper_right_corner="┐"
export border_lower_left_corner="└"
export border_lower_right_corner="┘"
export border_horizontal_line="─"
export border_vertical_line="│"
export border_cross="┼"
export border_tee_up="┴"
export border_tee_down="┬"
export border_tee_left="┤"
export border_tee_right="├"
export border_thick_upper_left_corner="┏"
export border_thick_upper_right_corner="┓"
export border_thick_lower_left_corner="┗"
export border_thick_lower_right_corner="┛"
export border_thick_horizontal_line="━"
export border_thick_vertical_line="┃"
export border_thick_cross="╋"
export border_thick_tee_up="┻"
export border_thick_tee_down="┳"
export border_thick_tee_left="┫"
export border_thick_tee_right="┣"
export border_doulbe_upper_left_corner="╔"
export border_doulbe_upper_right_corner="╗"
export border_doulbe_lower_left_corner="╚"
export border_doulbe_lower_right_corner="╝"
export border_doulbe_horizontal_line="═"
export border_doulbe_vertical_line="║"
export border_doulbe_cross="╬"
export border_doulbe_tee_up="╩"
export border_doulbe_tee_down="╦"
export border_doulbe_tee_left="╣"
export border_doulbe_tee_right="╠"

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
alias unix_secs='date +%s'
alias timestamp='date +%s_%Y-%m-%d_%I:%M_%p'

export LOGS=$HOME/LOGS; [ -d $LOGS ] || mkdir -p $LOGS

export -f latest-log
function latest-log() {
    # $1=prefix $2=postfix $3=which where 1 is most recent 2 is 2nd most recent etc
    local prefix=$1
    local postfix=$2
    local which=${3:-1} # default to '1' which is most recent
    ls -t $LOGS/$prefix*$postfix | sed -n "${which}p"
}

export -f c-log
function c-log() {
    code $(latest-log $*)
}

export -f term_width
function term_width() {
    echo $COLUMNS
    # NOTE: tried tput cols, but it gets capped at 80 columns
}

export -f back_from_eol
function back_from_eol() {
    local spaces=$((${1:-10} - 1))
    # get current cursor position and printf spaces equal to term_width - spaces - position
    printf "\033[6n" > /dev/tty
    tput sc
    tput hpa $(term_width)
    tput cub $spaces
}

export -f ffgrep
function ffgrep() {
    local regex=${1:-error}
    local files=${2:-$LOGS}
    local bar_len=${bar_len:-$(($(term_width) / 2))}
    local bar_scale=${bar_scale:-1}
    # WARN: this fn only scans top level of $files
    fd -d 1 idf-monitor $files | \
    xargs grep -a -c -i --color=never $regex | \
    sed -E 's/(^.*):([0-9]+)$/\1 \2/' | \
    awk \
        -v scale=$bar_scale \
        -v bar="${bar3:0:$bar_len}" \
        -v color="$YELLOW" \
        -v pos="$(back_from_eol $bar_len)" \
        -v nc="$RESET" \
        '$2 > 0 { \
            len = int(0.5+$NF*scale); \
            str = len ? substr(bar,0,len) : "|"; \
            printf "%s %s%s%s%s\n", $0, color, pos, str, nc; \
        }' | \
    sort --reverse
}

export -f ffgrep-p
function ffgrep-p() {
    local regex=${1:-error}
    local files=${2:-$LOGS}
    # derived from
    # ffgrep $regex $files | \
    # fzf --ansi --preview "\
        # echo {} | awk '{print \$1}' | \ 
        # xargs -I {} sh -c \
        # \"grep -a -i -m 1 'fw_ver' {}; \ 
        # grep -a -i $regex {}\" | \
        # " | \
    # awk '{print $1}'

}

export -f ffgit-diff
function ffgit-diff() {
    # derived from
    # git diff origin/main HEAD --stat | head -n -1 | fzf --height 100% --preview-window=up:36 --layout=reverse
    # --preview 'git diff -U0 --color=always origin -- ../$(echo {} | cut -d " " -f 2)' >/dev/null
    local branch_a=${1}
    local branch_b=${2}
    local preview_cmd="git diff "
        preview_cmd+=" -U0 --color=always "
        preview_cmd+=" ${branch_a} ${branch_b} "
        preview_cmd+=" -- "
        preview_cmd+=" ./\$( "
            preview_cmd+=" echo {} | cut -d \" \" -f 2 "
        preview_cmd+=" ) "

    git diff ${branch_a} ${branch_b} --stat --color=always | \
    head -n -1 | \
    sort -r -k 3 | \
    sed 's/$/\r/' | tee /dev/tty | sed 's/\r$//' | \
    fzf \
        --prompt="Diff: ${branch_a} ${branch_b} > " \
        --ansi \
        --height 67% \
        --preview-window=right:50% \
        --reverse \
        --preview ${preview_cmd} \
    >/dev/null
}

export -f ffgit-log
function ffgit-log() {
    # derived from
    # git logp | fzf --ansi --reverse --preview "echo {} | sed -n -E 's/^[^0-9a-f]*([0-9a-f]+).*/\1/p' | xargs -I {} git diff --stat --color {}\~1 {} 2>&1" 
    local preview_cmd="echo {} | "
        preview_cmd+="sed -n -E 's/^[^0-9a-f]*([0-9a-f]+).*/\1/p' | "
        preview_cmd+="xargs -I {} git diff --stat --color {}\~1 {} 2>&1"

    git logp | \
    fzf \
        --ansi \
        --height 67% \
        --preview-window=right:50% \
        --reverse \
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
