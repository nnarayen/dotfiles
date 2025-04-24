#! /bin/bash

# Own the current directory
sudo chown -R $(whoami):$(whoami) $(pwd)

sudo apt-get update
sudo apt install -y openssh-server xsel
sudo service ssh start

# Install NixOS, tools
curl -L https://nixos.org/nix/install | sh
$HOME/.nix-profile/bin/nix-env -iA nixpkgs.basedpyright nixpkgs.git nixpkgs.openssh nixpkgs.bat nixpkgs.fzf nixpkgs.ripgrep nixpkgs.fd nixpkgs.starship nixpkgs.zoxide nixpkgs.neovim nixpkgs.tmux nixpkgs.lua-language-server nixpkgs.yq

# Source Nix
source ~/.nix-profile/etc/profile.d/nix.sh

# Configure nvim
pushd $(dirname $0)
sudo chown -R $(whoami):$(whoami) ~/.config
sudo ln -f -s $PWD/vim ~/.config/nvim

# Configure tmux
sudo apt-get remove -y tmux fzf
sudo mkdir -p ~/.tmux/plugins
sudo chown -R $(whoami):$(whoami) ~/.tmux
sudo ln -f -s $PWD/tmux/tmux.conf ~/.tmux.conf
sudo ln -f -s $PWD/tmux/tmux-statusline-colors.conf ~/.tmux-statusline-colors.conf

# Download tpm, install plugins
sudo git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# Configure zsh, aliases
zsh_custom_dir=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
sudo ln -f -s $PWD/zsh/zshrc $zsh_custom_dir/zshrc-custom.zsh
sudo ln -f -s $PWD/zsh/b10_zshrc.zsh $HOME/.b10.zsh
sudo ln -f -s $PWD/zsh/zsh_aliases $zsh_custom_dir/zshrc-aliases.zsh

# Configure starship, custom prompt gets overriden
sudo ln -f -s $PWD/starship/starship.toml ~/.config/starship.toml

# Default shell is zsh
sudo chsh -s $(which zsh) $(whoami)

# Atuin setup
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
sudo mkdir -p ~/.config/atuin
sudo ln -f -s $PWD/atuin/config.toml $HOME/.config/atuin/config.toml

# Add additional zsh plugins
zsh_home=${ZSH:-~/.oh-my-zsh}
pushd $zsh_home/plugins
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git
sed -i 's/^plugins=(git)$/plugins=(git history-substring-search fast-syntax-highlighting)/' ~/.zshrc
popd

echo 'source "$HOME/.b10.zsh"' >> ~/.zshrc
