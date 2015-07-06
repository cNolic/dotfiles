# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

setopt promptsubst

# modify the prompt to contain git branch name if applicable
_git_status() {
  git_status=$(LANG=en_US.UTF-8 git status 2> /dev/null)
  if [ -n "$(echo $git_status | grep "Changes not staged")" ]; then
    echo "changed"
  elif [ -n "$(echo $git_status | grep "Changes to be committed")" ]; then
    echo "pending"
  elif [ -n "$(echo $git_status | grep "Untracked files")" ]; then
    echo "untracked"
  else
    echo "unchanged"
  fi
}

_git_prompt_info() {
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    current_git_status=$(_git_status)
    if [ "unchanged" = $current_git_status ]; then
      echo " %{$fg[green]%}$current_branch%{$reset_color%}"
    elif [ "pending" = $current_git_status ]; then
       echo " %{$fg[yellow]%}$current_branch%{$reset_color%}"
    elif [ "changed" = $current_git_status ]; then
      echo " %{$fg[red]%}$current_branch%{$reset_color%}"
    elif [ "untracked" = $current_git_status ]; then
      echo " %{$fg[cyan]%}$current_branch%{$reset_color%}"
    else
      echo " $current_branch"
    fi
  fi
}

export PS1='%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~%{$reset_color%}$(_git_prompt_info) %# '

# load completion functions
fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit

# load custom functions
for function in ~/.zsh/functions/*; do
  source $function
done

setopt autocd

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode


# keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# rbenv
eval "$(rbenv init -)"

export QUILT_PATCHES="debian/patches"
export QUILT_REFRESH_ARGS="-p ab --no-timestamps --no-index"
