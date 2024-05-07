# document commands to run on a new macos installation

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install brew packages
brew bundle

# clone dotfiles
chezmoi init --apply https://github.com/jemorriso/chezmoi.git

# install rust and cargo
curl https://sh.rustup.rs -sSf | sh

# install cargo packages
source ./cargo_package_install.sh

# install pipx packages
set -ux
if [[ -e ./pipx_packages.json ]]; then
	for p in $(cat ./pipx_packages.json | jq -r '.venvs[].metadata.main_package.package_or_url'); do
		pipx install $p
	done
fi

# install github repos
source ./github_repo_clone.sh

# make venvs, must be run after github_repo_clone.sh
source ./venvs.sh

# install oh-my-zsh & custom plugins
source ./oh_my_zsh.sh
