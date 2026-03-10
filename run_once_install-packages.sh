#!/usr/bin/env bash
set -e

sudo apt update

sudo apt install -y \
  git \
  zsh \
  tmux \
  neovim \
  fzf \
  foot \
  openjdk-17-jdk
