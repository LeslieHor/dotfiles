#       _               _
#      | |__   __ _ ___| |__  _ __ ___
#      | '_ \ / _` / __| '_ \| '__/ __|
#   _  | |_) | (_| \__ \ | | | | | (__
#  (_) |_.__/ \__,_|___/_| |_|_|  \___|

# ------------------------------------------------------------------------------
# Only do this if interactive mode
# ------------------------------------------------------------------------------
case $- in
    *i*) ;;
      *) return;;
esac

# ------------------------------------------------------------------------------
# History
# ------------------------------------------------------------------------------
shopt -s histappend
HISTSIZE=3000
HISTFILESIZE=6000
HISTTIMEFORMAT='%F %T '
HISTIGNORE='ls:history'
PROMPT_COMMAND='history -a ; $PROMPT_COMMAND'

# ------------------------------------------------------------------------------
# Add paths
# ------------------------------------------------------------------------------
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin

# ------------------------------------------------------------------------------
# Load extra files
# ------------------------------------------------------------------------------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi

if [ -d "$HOME/adb-android/platform-tools" ] ; then
 export PATH="$HOME/adb-android/platform-tools:$PATH"
fi

# ------------------------------------------------------------------------------
# Editors
# ------------------------------------------------------------------------------
export ALTERNATE_EDITOR=""
export EDITOR="vim"
export VISUAL="emacsclient -c -a emacs"
