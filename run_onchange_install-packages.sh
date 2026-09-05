#!/usr/bin/env bash
set -e

case "$(uname -s)" in
  Darwin)
    command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install git zsh tmux neovim fzf jq gh
    ;;
  Linux)
    sudo apt update
    sudo apt install -y git zsh tmux neovim fzf foot jq gh
    ;;
esac
