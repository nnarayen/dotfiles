#! /bin/bash

# Run SSH service on port 22
sudo apt install -y openssh-server
sudo service ssh start

# Install dependencies
brew install neovim ripgrep fzf bat fd zoxide starship hub tmux

# Configure nvim
pushd $(dirname $0)
ln -f -s $PWD/vim ~/.config/nvim

# Configure tmux, brew version is required for clipboard functionality
sudo apt-get remove -y tmux
ln -f -s $PWD/tmux/tmux.conf ~/.tmux.conf
ln -f -s $PWD/tmux/tmux-statusline-colors.conf ~/.tmux-statusline-colors.conf

# Download tpm, install plugins
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# Configure zsh, aliases
ln -f -s $PWD/zsh/zshrc $ZSH_CUSTOM/zshrc-custom.zsh
ln -f -s $PWD/zsh/zsh_aliases $ZSH_CUSTOM/zshrc-aliases.zsh

# Configure starship, custom prompt gets overriden
echo "eval \"\$(starship init zsh)\"" >> ~/.zshrc
ln -f -s $PWD/starship/starship.toml ~/.config/starship.toml

# Extra steps
#   1) Remove starship from zshrc
#   2) Add history-substring-search to ~/.zshrc plugins
