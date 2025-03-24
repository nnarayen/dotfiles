#! /bin/bash

# Run SSH service on port 22
sudo apt-get update
sudo apt install -y openssh-server xsel hub
sudo service ssh start

# Set default target architecture if not defined
DEFAULT_ARCH="aarch64-unknown-linux-gnu"

install_tool() {
  local github_package version_spec binary arch

  # Parse key=value pairs from the arguments.
  for kv in "$@"; do
	case $kv in
	  github=*) github_package="${kv#github=}";;
	  version=*) version_spec="${kv#version=}";;
	  binary=*) binary="${kv#binary=}";;
	  arch=*) arch="${kv#arch=}";;
	esac
  done

  # Use repository name (second portion of github_package) for the URL.
  local repo download_tag file_prefix
  repo=$(echo "$github_package" | cut -d'/' -f2)
  download_tag=$(echo "$version_spec" | cut -d'/' -f1)
  file_prefix=$(echo "$version_spec" | cut -d'/' -f2)

  # Default binary: if not provided, use repo.
  binary=${binary:-$repo}

  # Default architecture.
  arch=${arch:-$DEFAULT_ARCH}

  # Build the download URL.
  local url="https://github.com/${github_package}/releases/download/${download_tag}/${file_prefix}-${arch}.tar.gz"
  echo "Installing $binary using URL: $url"

  # Download tarball into a temporary file.
  local tmp_file="/tmp/${file_prefix}.tar.gz"
  rm -f "$tmp_file"
  wget "$url" -O "$tmp_file" || { echo "Error: Failed to download $url" >&2; exit 1; }

  # Create a temporary directory for extraction.
  local extract_dir
  extract_dir=$(mktemp -d)
  tar xvzf "$tmp_file" -C "$extract_dir" || { echo "Error: Failed to extract $tmp_file" >&2; exit 1; }

  # Search for the expected binary.
  echo "Searching for binary '$binary' in $extract_dir..."
  local binary_path
  binary_path=$(find "$extract_dir" -maxdepth 2 -type f -name "$binary" | head -n 1)
  if [[ -z "$binary_path" ]]; then
	echo "Error: Expected binary '$binary' not found in $extract_dir" >&2
	exit 1
  fi

  echo "Found binary at $binary_path"
  echo "Moving $binary_path to /usr/local/bin/$binary..."
  sudo mv "$binary_path" "/usr/local/bin/$binary"
  sudo chmod +x "/usr/local/bin/$binary"
  echo "$binary installed successfully to /usr/local/bin/$binary"

  # Clean up.
  rm -rf "$extract_dir" "$tmp_file"
}

# Define your tools using key=value pairs.
tools=(
  "github=sharkdp/bat version=v0.25.0/bat-v0.25.0"
  "github=junegunn/fzf version=v0.60.3/fzf-0.60.3 arch=linux_arm64"
  "github=BurntSushi/ripgrep binary=rg version=14.1.1/ripgrep-14.1.1"
  "github=sharkdp/fd version=v10.2.0/fd-v10.2.0"
  "github=starship/starship version=v1.22.1/starship arch=aarch64-unknown-linux-musl"
  "github=ajeetdsouza/zoxide version=v0.9.7/zoxide-0.9.7 arch=aarch64-unknown-linux-musl"
)

# Loop through each tool and install it.
for tool in "${tools[@]}"; do
  install_tool $tool
done

# Install NixOS, tools
curl -L https://nixos.org/nix/install | sh
$HOME/.nix-profile/bin/nix-env -iA nixpkgs.basedpyright

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
