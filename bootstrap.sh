#! /bin/bash

# Run SSH service on port 22
sudo apt-get update
sudo apt install -y openssh-server
sudo service ssh start

# Install dependencies
brew install neovim ripgrep fzf bat fd zoxide starship hub tmux basedpyright xsel

# Configure nvim
pushd $(dirname $0)
sudo ln -f -s $PWD/vim ~/.config/nvim

# Configure tmux, brew version is required for clipboard functionality
sudo apt-get remove -y tmux
sudo ln -f -s $PWD/tmux/tmux.conf ~/.tmux.conf
sudo ln -f -s $PWD/tmux/tmux-statusline-colors.conf ~/.tmux-statusline-colors.conf

# Download tpm, install plugins
sudo mkdir -p ~/.tmux/plugins
sudo git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# Configure zsh, aliases
zsh_custom_dir=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
sudo ln -f -s $PWD/zsh/zshrc $zsh_custom_dir/zshrc-custom.zsh
sudo ln -f -s $PWD/zsh/zsh_aliases $zsh_custom_dir/zshrc-aliases.zsh

# Configure starship, custom prompt gets overriden
echo "eval \"\$(starship init zsh)\"" >> ~/.zshrc
sudo ln -f -s $PWD/starship/starship.toml ~/.config/starship.toml

# Extra steps
#   1) Add history-substring-search, syntax highlighting to ~/.zshrc plugins
