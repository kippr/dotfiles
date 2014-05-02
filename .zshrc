# DESCRIPTION:
#   A simple zsh configuration that gives you 90% of the useful features that I use everyday.
#
# AUTHOR:
#   Geoffrey Grosenbach http://peepcode.com


if [[ -d ~/bin ]] ; then export PATH=~/bin:${PATH}; fi
if [[ -d /usr/local/share/python ]] ; then export PATH=${PATH}:/usr/local/share/python; fi
export PATH=/usr/local/bin:${PATH}

# todo: kp: put symlinks in /usr/local/bin instead?
export PATH=${PATH}:/usr/local/Cellar/python/2.7.3/lib/python2.7/distutils:/usr/local/mysql/bin/:~/ac/bin

export MYSQLDUMP=/Applications/MAMP/Library/bin/mysqldump
export MYSQL=/Applications/MAMP/Library/bin/mysql

# kp: rainy: without this, mysql-python can't find deps. Another way to do that?
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

#export DJANGO_SETTINGS_MODULE=crmweb.settings
export DJANGO_SETTINGS_MODULE=misweb.settings
export PROJ_ROOT=~/ac

# virtualenv
export WORKON_HOME=~/ac/Environments
source /usr/local/bin/virtualenvwrapper.sh
function venv-prompt() {
    echo $(basename ${VIRTUAL_ENV:-''})
}


export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=~/.history

export KNIFE_USER=kippr

# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

# Colors
autoload -U colors
colors
setopt prompt_subst
#setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
#setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Prompt
local smiley="%(?,%{$fg[green]%}☺%{$reset_color%},%{$fg[red]%}☹%{$reset_color%})"

PROMPT='
%~
${smiley}  %{$reset_color%}'

RPROMPT='%{$fg[white]%} $(venv-prompt) $(~/.rvm/bin/rvm-prompt)$(~/.zsh/git-cwd-info.rb)%{$reset_color%}'

[ -n "$TMUX" ] && export TERM=screen-256color

# Show completion on first TAB
zstyle ':completion:*' menu select=0

# Load completions for Ruby, Git, etc.
autoload compinit
compinit

# VI mode
bindkey -v
bindkey "jj" vi-cmd-mode
bindkey "^R" history-incremental-search-backward

# flip into vi for editing command with v
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Smart pane switching with awareness of vim splits
# I should be able to add this to .tmux.conf but its being ignored there?
if [ $(tmux has-session > /dev/null 2>&1) ] ; then
    tmux bind-key -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-h) || tmux select-pane -L"
    tmux bind-key -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-j) || tmux select-pane -D"
    tmux bind-key -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-k) || tmux select-pane -U"
    tmux bind-key -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-l) || tmux select-pane -R"
    tmux bind-key -n C-\\ run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys 'C-\\') || tmux select-pane -l"
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

alias ll="ls -lah"
alias lr="ls -lahtr"

alias g=/usr/bin/git
alias gi="clear && /usr/bin/git"
alias gd="git diff"
alias gr="git r"
alias gaa="git aa"
alias test_results="cat /tmp/last_build.out| sed 's/\\n/
/g' |less"
alias be="bundle exec"

function wo() {
    workon $( ls -l ~/ac/Environments | grep '^d' | egrep -o '\S+$' | selecta)
}

function ac() {
    cd $(find ~/ac ~/code ~/code/forks -type d -maxdepth 1 | selecta)
}

function psgrep()
{
    ps -ef |grep -i $1 | grep -v $$
}

function kpgrep()
{
    ack "$1" -H --noheading ~/ac/kp |selecta | cut -f 1 -d ':' | sed 's/.*/"&"/' | xargs open
}


if [ -d ~/ac/.conf.d ] ; then
    source ~/ac/.conf.d/.bashrc.common
    source ~/ac/.conf.d/.bashrc.avoca
    source ~/ac/.conf.d/.bashrc.mac
fi

export YAY=😄
export BOO=😡
function tg()
{
    t git $@
}

function t()
{
    start=`date +%s`
    "$@"
    x=$?
    runtime=$(( `date +%s` - $start ))
    if [ $x -eq 0 ]
    then cmdemoji=$YAY
    else cmdemoji=$BOO
    fi
    terminal-notifier -title "${cmdemoji} $( echo $@ )" -message "CMD#$HISTCMD took $runtime secs" -activate com.apple.Terminal -sender com.apple.Terminal >/dev/null
    return $x
}

