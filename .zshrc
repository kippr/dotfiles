# DESCRIPTION:
#   A simple zsh configuration that gives you 90% of the useful features that I use everyday.
#
# AUTHOR:
#   Geoffrey Grosenbach http://peepcode.com


if [[ -d ~/bin ]] ; then export PATH=~/bin:${PATH}; fi
if [[ -d /usr/local/share/python ]] ; then export PATH=${PATH}:/usr/local/share/python; fi
export PATH=/usr/local/bin:${PATH}

# todo: kp: put symlinks in /usr/local/bin instead?
export PATH=${PATH}:/usr/local/Cellar/python/2.7.3/lib/python2.7/distutils:/usr/local/mysql/bin:~/ac/bin

export MYSQLDUMP=/usr/local/bin/mysqldump
export MYSQL=/usr/local/bin/mysql

# where? java you're embarrassing yourself
export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"

# kp: rainy: without this, mysql-python can't find deps. Another way to do that?
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

#export DJANGO_SETTINGS_MODULE=crmweb.settings.local-mac
#export DJANGO_SETTINGS_MODULE=misweb.settings
export PROJ_ROOT=~/ac

# virtualenv
export WORKON_HOME=~/ac/Environments
source /usr/local/bin/virtualenvwrapper.sh
function venv-prompt() {
    echo $(basename ${VIRTUAL_ENV:-''})
}

function frameworkpython {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python "$@"
    else
        /usr/local/bin/python "$@"
    fi
}


export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=~/.history

export KNIFE_USER=kippr

export MP1=2811

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


# disable ctrl-s  (used to pause terminal updates)
stty -ixon

# Prompt
local bg_jobs="%(1j,%{$fg[blue]%},%{$fg[green]%})"
local happy=" ❃ "
local sad="ಠ_ಠ"
local smiley="%(?,${happy},${sad})%{$reset_color%}"

PROMPT='
%~
${bg_jobs}${smiley}  %{$reset_color%}'

function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    TIME_PROMPT="%F{cyan}${timer_show}s %{$reset_color%} "
    unset timer
  else
  fi
}
RPROMPT='${TIME_PROMPT}$(venv-prompt) %{$fg[white]%} $(~/.zsh/git-cwd-info.rb)%{$reset_color%}'

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
    # git part in below is mayby dodgy but when else do I have git active when not using mergetool etc and hit
    # ctrl-l etc
    tmux bind-key -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)(git|vim)(diff)?$' && tmux send-keys C-h) || tmux select-pane -L"
    tmux bind-key -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)(git|vim)(diff)?$' && tmux send-keys C-j) || tmux select-pane -D"
    tmux bind-key -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)(git|vim)(diff)?$' && tmux send-keys C-k) || tmux select-pane -U"
    tmux bind-key -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)(git|vim)(diff)?$' && tmux send-keys C-l) || tmux select-pane -R"
    tmux bind-key -n C-\\ run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)(git|vim)(diff)?$' && tmux send-keys 'C-\\') || tmux select-pane -l"
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# use gnu readlink in my shell
alias readlink=greadlink

alias ll="ls -lah"
alias lr="ls -lahtr"

alias g=/usr/bin/git
alias gi="clear && /usr/bin/git"
alias gd="git diff"
#alias gr="git r"
alias gaa="git aa"
alias gf="git fetch"
alias test_results="cat /tmp/last_build.out| sed 's/\\n/
/g' |less"
alias be="bundle exec"
alias ccat='pygmentize -g'

alias pbc=pbcopy
alias pbp=pbpaste

function wo() {
    if [ -n "$1" ] ; then selecta_args="--search $1"; fi
    choices=$(find ~/ac ~/code ~/code/forks -type d -maxdepth 1)
    chosen=$(echo "$choices\n/Users/kip/Weldam\n/Users/kip/Personal\n/Users/kip/admin"| selecta $selecta_args)
    chosen_dir=$(echo "$chosen" | rev | cut -d '/' -f 1 | rev)
    for ve in $(workon); do
        if [ "$ve" = "$chosen_dir" ]; then
            workon $ve
            break;
        fi
    done
    if [ -n "$1" ] ; then unset selecta_args ; fi
    pushd $chosen
}
zle -N wo
bindkey "^w" "wo"


function cds() {
    if [ -n "$1" ] ; then selecta_args="--search $1"; fi
    cd $(find . -type d | selecta $selecta_args)
    selecta_args=""
}

function psgrep()
{
    ps -ef |grep -i $1 | grep -v $$
}

function kpgrep()
{
    ack "$1" -H --noheading ~/ac/kp |selecta | cut -f 1 -d ':' | sed 's/.*/"&"/' | xargs open
}


# patience is a virtue
function piav()
{
    chosen=$(jobs|grep suspended | selecta | cut -c 2)
    job_title=$(jobs|grep "[${chosen}]"| cut -c 19-)
    echo "Will ping you when [$chosen] \"$job_title\" completes"
    bg;
    wait "%${chosen}";
    osascript -e "display notification \"Finished running ${job_title}\" with title \"Job ${chosen} done.\""
}


# https://github.com/garybernhardt/dotfiles/blob/68554d69652cc62d43e659f2c6b9082b9938c72e/.zshrc#L122
# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol
# Run Selecta in the current working directory, appending the selected path, if
# any, to the current command.
function insert-selecta-path-in-command-line() {
    local selected_path
    # Print a newline or we'll clobber the old prompt.
    echo
    # Find the path; abort if the user doesn't select anything.
    selected_path=$(find * -type f | selecta) || return
    # Append the selection to the current command buffer.
    eval 'LBUFFER="$LBUFFER$selected_path"'
    # Redraw the prompt since Selecta has drawn several new lines of text.
    zle reset-prompt
}
# Create the zle widget
zle -N insert-selecta-path-in-command-line
# Bind the key to the newly created widget
bindkey "^S" "insert-selecta-path-in-command-line"


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


. <(gr completion)
