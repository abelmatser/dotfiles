# ZSH config
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="sayanee"
CASE_SENSITIVE="false"
SHELL="/bin/zsh"
COMPLETION_WAITING_DOTS="true"
plugins=(git node npm github git-flow docker bgnotify git-open)
unsetopt SHARE_HISTORY

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh
source ~/.git-flow-completion.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# common alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias desk='cd ~/Desktop && clear'
alias ll='ls -lah'
alias man="man -a"
alias rd='rm -rf'
alias server="python -m SimpleHTTPServer 8000 && open http://localhost:8000"
alias src='source ~/.zshrc'

# cli alias
alias ls='exa'
alias cat='bat'

# common git alias
# alias git='/usr/local/bin/git' # take the brew install
alias ga='git add '
alias gb='git branch '
alias gc='git commit -m '
alias gd='git diff '
# alias gl="git log --graph --abbrev-commit --decorate --date=short --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar on %cd)%C(reset) %C(cyan)%s%C(reset) %C(red)by %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gl="git log --graph --oneline"
alias gla="gl --all"
alias goo='git checkout '
alias gp='git pull && git push'
alias gpm='git switch master && gp && git switch -'
alias gr='git add -u && git commit -m '
alias gs='git status --untracked-files'

# https://gist.github.com/SlexAxton/4989674
gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

# killport 4000
killport() {
  kill -TERM `lsof -t -i:$1`
}

# get_test localhost:4000
http_test() {
  while true; do
    resp=$(curl --write-out "Status : %{http_code}, Response Time: %{time_total}s" $1 -s --output /dev/null)
    echo `date "+%H:%M:%S"`, $resp
    if  [ -z "$2" ]; then
      sleepTime=0.1
    else
      sleepTime=$2
    fi
    sleep $sleepTime
  done
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

iterm2_print_user_vars() {
  # extend this to add whatever
  # you want to have printed out in the status bar
  iterm2_set_user_var nodeVersion $(node -v)
  iterm2_set_user_var rubyVersion $(ruby --version | awk '{ print $2 }')
  iterm2_set_user_var pythonVersion $(python3 --version | awk '{ print $2 }')
}

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/usr/local/opt/texinfo/bin:$PATH"
export GEM_HOME="$HOME/.gem"
