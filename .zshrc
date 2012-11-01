# DESCRIPTION:
#   A simple zsh configuration that gives you 90% of the useful features that I use everyday.
#
# AUTHOR:
#   Geoffrey Grosenbach http://peepcode.com


export PATH=${PATH}:/usr/local/bin
if [[ -d ~/bin ]] ; then export PATH=${PATH}:~/bin; fi
if [[ -d /usr/local/share/python ]] ; then export PATH=${PATH}:/usr/local/share/python; fi

# todo: kp: put symlinks in /usr/local/bin instead?
export PATH=${PATH}:/usr/local/Cellar/python/2.7.3/lib/python2.7/distutils:/usr/local/mysql/bin/:~/ac/bin

export MYSQLDUMP=/Applications/MAMP/Library/bin/mysqldump
export MYSQL=/Applications/MAMP/Library/bin/mysql
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

export DJANGO_SETTINGS_MODULE=crmweb.settings


# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

# Colors
autoload -U colors
colors
setopt prompt_subst

# Prompt
local smiley="%(?,%{$fg[green]%}☺%{$reset_color%},%{$fg[red]%}☹%{$reset_color%})"

PROMPT='
%~
${smiley}  %{$reset_color%}'

RPROMPT='%{$fg[white]%} $(~/.rvm/bin/rvm-prompt)$(~/.zsh/git-cwd-info.rb)%{$reset_color%}'

# Show completion on first TAB
zstyle ':completion:*' menu select=0

# Load completions for Ruby, Git, etc.
autoload compinit
compinit

# VI mode
bindkey -v
bindkey "jj" vi-cmd-mode

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

alias ll="ls -latr"
