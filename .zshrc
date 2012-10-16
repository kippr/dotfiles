# DESCRIPTION:
#   A simple zsh configuration that gives you 90% of the useful features that I use everyday.
#
# AUTHOR:
#   Geoffrey Grosenbach http://peepcode.com


if [[ -d ~/bin ]] ; then export PATH=${PATH}:~/bin; fi

# todo: kp: better way?
export PATH=${PATH}:/usr/local/Cellar/python/2.7.3/bin/:/usr/local/share/python:/usr/local/Cellar/python/2.7.3/lib/python2.7/distutils:/usr/local/mysql/bin/:~/ac/bin

export MYSQLDUMP=/Applications/MAMP/Library/bin/mysqldump
export MYSQL=/Applications/MAMP/Library/bin/mysql
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH


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

