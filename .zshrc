#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

#autoload -Uz vcs_info
#zstyle ':vcs_info:*' actionformats \
#    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
#zstyle ':vcs_info:*' formats       \
#    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{220}%S%f:%F{2}%b%f:%F{6}%r%f%F{5}]%f '
#zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

#zstyle ':vcs_info:*' enable git svn
# left prompt: "[user - date] - dir \n->"
PROMPT=$'[%F{40}%n%f@%F{220}%m%f - %F{80}%*%f] - %F{220}%~%f\n->'

# right prompt: git info
#source ~/.git-prompt.sh
setopt PROMPT_SUBST

setopt no_share_history
unsetopt share_history

#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
#vcs_info_wrapper() {
#	if [ -n "$vcs_info_msg_0_" ]; then
#		echo "%F{40}${vcs_info_msg_0_}%f"
#	fi
#}
# RPROMPT=$'$(vcs_info_wrapper)'

function git_info()
{
  repo=$(git config --local remote.origin.url 2>/dev/null)
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $repo == "" ]];
  then
    :
  else
    repo=$(basename $repo .git)
    changes=$(git status -uno -s 2> /dev/null | wc -l)
    staged=$(git status -uno -s 2> /dev/null | grep -c "^[MTADRCU]")
    if [ $changes -gt 0 ]; then
      prefix=+%f
      if [ $staged -gt 0 ]; then
         prefix=%F{green}$prefix
      else
         prefix=%F{red}$prefix
      fi
      echo '['%B$prefix%F{green}$repo%f%b' ('$branch')]'
    else
      echo '['%B%F{green}$repo%f%b' ('$branch')]'
    fi
  fi
}
# Enable substitution in the prompt.
setopt prompt_subst

# Config for prompt. PS1 synonym.
RPROMPT='$(git_info)'


eval `dircolors ${ZDOTDIR:-$HOME}/.dircolors-moonshine`
alias rm="rm -v"
PATH=$PATH:${ZDOTDIR:-$HOME}/.installs/intelFPGA/quartus/bin:${ZDOTDIR:-$HOME}/.local/bin
alias quartus64="quartus --64bit"
alias ll='ls -l'
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
export PAGER=most
