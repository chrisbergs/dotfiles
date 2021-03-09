#
# ~/.bashrc
#

# Enable vi mode
# set -o vi

# Script vars
export MONITOR1='HDMI-0'
export MONITOR2='DP-1'
export SCREEN_X=1920
export SCREEN_Y=1080

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '

# Vars
export CARGO_NET_GIT_FETCH_WITH_CLI=true
export CARGO_TARGET_DIR=_bin
export TERM=xterm-256color
#export TERM=rxvt-unicode-256color
#export TERM=screen-256color
export BROWSER=firefox
export EDITOR=nvim
export SYSTEMD_EDITOR=nvim
export RANGER_LOAD_DEFAULT_RC=false
export FZF_DEFAULT_COMMAND="rg --files --hidden --no-messages -g '!.git' -g '!.dots' -g '!_bin'"
export FZF_DEFAULT_OPTS='
	--color bg:-1
	--color bg+:-1
	--color prompt:-1
	--bind ctrl-space:toggle-sort
'

export XZ_OPT="-T8"

alias lgb='goobook -c ~/.goobook/leaty'
alias vgb='goobook -c ~/.goobook/vizzit'
alias lm='neomutt -F ~/.mutt/leaty'
alias vm='neomutt -F ~/.mutt/vizzit'
alias ls='ls --color=auto --group-directories-first'
alias db1='LESS=-SRXF mycli --defaults-file=$HOME/.mysql/db1.conf'
alias tag1='LESS=-SRXF mycli --defaults-file=$HOME/.mysql/tag1.conf'
alias tag2='LESS=-SRXF mycli --defaults-file=$HOME/.mysql/tag2.conf'
alias dots='git --git-dir=$HOME/.dots/ --work-tree=$HOME'
alias ccat='vimcat'
alias vim='nvim'
alias svim='sudoedit'

# Command to open vim sessions
code() {
	if [ -z "$1" ]; then
		nvim -c :Sessions
	elif [ ! -f "~/.vim/session/$1" ]; then
		nvim -S ~/.vim/session/$1
	else
		echo "Session $1 does not exist."
	fi
}

# SAMESHELL
SAMESHELL=$(cat ~/.config/sameshell/bashrc | sed '/^#/d' | base64)
SAMESHELL_REAL="~/.bashrc"
SAMESHELL_CMD="bash --rcfile <(cat $SAMESHELL_REAL; echo \"SAMESHELL='$SAMESHELL'\"; echo '. <(echo \"\$SAMESHELL\" | base64 --decode)')"
zh() { /usr/bin/ssh -t $@ "$SAMESHELL_CMD"; }
zo() { /usr/bin/sudo $@ --session-command "$SAMESHELL_CMD"; }
zu() { /usr/bin/su $@ --session-command "$SAMESHELL_CMD"; }

# Pywal
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

