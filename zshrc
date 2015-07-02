# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

setopt promptsubst

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo "%{$fg[blue]%}$current_branch%{$reset_color%}"
  fi
}

PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%# "
RPROMPT="$(git_prompt_info)"

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

