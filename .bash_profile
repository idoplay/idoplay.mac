export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
[ -f ~/.git-bash-completion.sh ] && . ~/.git-bash-completion.sh

# git-ps1
if [ -x "$HOME/bin/git-ps1.sh" ]; then
    PS1="$PS1\$($( cat $HOME/bin/git-ps1.sh ))"
fi

keychain ~/.ssh/id_rsa

PATH=$PATH:$HOME/.local/bin:$HOME/bin:~/.composer/vendor/bin
