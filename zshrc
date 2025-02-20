export PATH=~/.local/bin:/Users/pietarisulkava/Dev/flutter/bin:$PATH
. ~/.local/lib/python3.10/site-packages/powerline/bindings/zsh/powerline.zsh

alias cat="bat"
alias ls="eza --git"
alias vim="nvim"
alias rsync="rsync -avzC"
alias runit="~/Scripts/runit.sh"
alias devit="~/Scripts/devit.sh"
alias startit="~/Scripts/startit.sh"
alias gst="git status"
alias gadd="git add"
alias ginit="git init"
alias grp="grep -r --exclude-dir=node_modules --exclude-dir=dist --exclude=tsconfig.tsbuildinfo"
alias cr="cursor"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# auto use appropriate node version based on nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export EDITOR=/usr/bin/nvim
export COMPOSE_TLS_VERSION=TLSv1_2

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
