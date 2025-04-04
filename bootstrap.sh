#! /bin/bash

# Run SSH service on port 22
sudo apt-get update
sudo apt install -y openssh-server xsel
sudo service ssh start

# Set default target architecture if not defined
DEFAULT_ARCH="aarch64-unknown-linux-gnu"


# Loop through each tool and install it.
for tool in "${tools[@]}"; do
  install_tool $tool
done

# Install NixOS, tools
curl -L https://nixos.org/nix/install | sh
$HOME/.nix-profile/bin/nix-env -iA nixpkgs.basedpyright nixpkgs.git nixpkgs.openssh nixpkgs.bat nixpkgs.fzf nixpkgs.ripgrep nixpkgs.fd nixpkgs.starship nixpkgs.zoxide

# asdf tools
asdf plugin-add tmux
asdf install tmux 3.5a
asdf global tmux 3.5a

# Install neovim
if ! command -v nvim >/dev/null 2>&1; then
  sudo apt-get update && sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
  git clone https://github.com/neovim/neovim.git /tmp/neovim
  pushd /tmp/neovim
  git checkout v0.10.4
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  popd
fi

# Configure nvim
pushd $(dirname $0)
sudo chown -R $(whoami):$(whoami) ~/.config
sudo ln -f -s $PWD/vim ~/.config/nvim

# Configure tmux
sudo apt-get remove -y tmux
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
sudo ln -f -s $HOME/.zshrc-secrets $zsh_custom_dir/zshrc-secrets.zsh

# Configure starship, custom prompt gets overriden
sudo ln -f -s $PWD/starship/starship.toml ~/.config/starship.toml

# Default shell is zsh
sudo chsh -s $(which zsh) $(whoami)

# Add additional zsh plugins
zsh_home=${ZSH:-~/.oh-my-zsh}
pushd $zsh_home/plugins
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git
sed -i 's/^plugins=(git)$/plugins=(git history-substring-search fast-syntax-highlighting)/' ~/.zshrc
popd

echo 'source "$HOME/.b10.zsh"' >> ~/.zshrc
# Extra steps
#   1) Add history-substring-search, syntax highlighting to ~/.zshrc plugins
