#!/bin/bash

if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$NAME
  VER=$VERSION_ID
fi

echo $OS

if [[ $OS == *"Arch"* ]]; then
  arch=true
elif [ "$OS" == "Ubuntu" ]; then
  arch=true
else
  echo "Distro not supported, sorry :("
fi

join_arr() {
  local IFS="$1"
  shift
  echo "$*"
}

if [ -n "$arch" ]; then
  deps=()

  if ! [ -x "$(command -v python)" ]; then
    deps+=("python")
  else
    echo "python already installed"
  fi

  if sudo pacman -Qi python-pynvim &> /dev/null ; then
    echo "python-pynvim already installed"
  else
    deps+=("python-pynvim")
  fi

  if ! [ -x "$(command -v fzf)" ]; then
    deps+=("fzf")
  else
    echo "fzf already installed"
  fi

  if ! [ -x "$(command -v fd)" ]; then
    deps+=("fd")
  else
    echo "fd already installed"
  fi

  if ! [ -x "$(command -v rg)" ]; then
    deps+=("ripgrep")
  else
    echo "ripgrep already installed"
  fi

  if ! [ -x "$(command -v lazygit)" ]; then
    deps+=("lazygit")
  else
    echo "lazygit already installed"
  fi

  depLen=${#deps[@]}
  if ! [ $depLen == 0 ]; then
    sudo pacman -S $(join_arr \  "${deps[@]}")
  fi
fi

if [ ! -d ~/.nvm ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  . ~/.nvm/nvm.sh
  nvm install node
  echo "Installed NVM"
fi

if npm list -g neovim &> /dev/null ; then
  echo "NPM Neovim already installed globally"
else
  npm i -g neovim
fi
