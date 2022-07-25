# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Colors! :D 
if [ -x /usr/bin/dircolors ]; then
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

export SUDO_EDITOR=nvim
export PATH=.:"/home/zlare/.local/bin":$PATH

# adding aliases
alias srun='f() { $@ &> /dev/null & disown; unset -f f; }; f'
alias reload='source ~/.zshrc'
alias backup='f() { cp $1 $1.1; unset -f f; }; f'
alias eww=~/src/eww/target/release/eww
alias mpt="python3 ~/docs/src/ModPackageManager/mpt.py"
alias sw='f() { cd ../$@; unset -f f; }; f'
alias sizeof="du --si --max-depth=0"
alias rr="sudo cp /etc/resolv.conf_saved /etc/resolv.conf"
alias using='f() { source $HOME/.lib/$@; unset -f f; }; f'
alias rundesk="python3 $HOME/run/zlare-tooling/rundesk.py"

# "$(awk '/^Exec=/{sub(/^Exec=/, ""); print}')"  # launches desktop files

# dangerous aliases 
alias srestart='f() { echo Restarting $1...; killall $1; srun $1; echo Done!; }; f'
alias quitwine="wineserver -k && pkill -9 \\.exe"


# other files
source ~/.aws.zshrc
source ~/.go.zshrc
source ~/.samba.zshrc
source ~/.unrealengine.zshrc
