# -*- mode: sh; -*-
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ls='ls --color=auto'
alias l='ls'
alias copy="xclip -i -selection clipboard"
alias payst="xclip -o -selection clipboard"
alias hg="history | grep"
alias img="sxiv"
alias emacs="emacsclient --alternate-editor='' --no-wait"
alias emact="emacsclient -t --alternate-editor=''"
alias emacs-new="emacsclient -c -n"
alias flush-caches="systemd-resolve --flush-caches ; systemd-resolve --statistics"
alias gitroot="while ! $(ls .git &> /dev/null) && [[ ! $(pwd) == '/' ]]; do cd .. ; done"
