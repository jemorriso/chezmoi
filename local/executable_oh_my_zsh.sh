sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cd ~/.oh-my-zsh/custom/plugins
gh repo clone Aloxaf/fzf-tab
gh repo clone zsh-users/zsh-autosuggestions
gh repo clone zsh-users/zsh-completions
gh repo clone zsh-users/zsh-history-substring-search
gh repo clone zsh-users/zsh-syntax-highlighting
gh repo clone jeffreytse/zsh-vi-mode

