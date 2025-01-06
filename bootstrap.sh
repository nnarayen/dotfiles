#! /bin/bash

# Run SSH service on port 22
sudo apt install openssh-server
sudo service ssh start

# Install dependencies
brew install neovim ripgrep fzf
