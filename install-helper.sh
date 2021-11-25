# !/bin/bash
source ./.vars.sh
echo "Installing Git..."
sudo yum install git
echo "Creating Workspace Directory..."
mkdir workspace
echo "Accessing Git Directory..."
cd workspace/
echo "Git is now installed..."

git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_EMAIL

echo "Generating SSH key for GitHub..."
ssh-keygen -t ed25519 -C $email -f $GIT_KEY_NAME
echo "Moving SSH Key To Storage (~/.ssh)..."
mv gh ~/.ssh/
echo "Setting SSH Key Permissions..."
chmod 400 ~/.ssh/gh
echo "Starting ssh-agent..."
eval "$(ssh-agent -s)"
echo "Adding SSH Key To Agent..."
ssh-add ~/.ssh/$GIT_KEY_NAME
echo "Add this public key to github"
cat "$GIT_KEY_NAME".pub
read -p "Press enter once you have entered in the key"
echo "-----Finished-GitHub-Setup-----\n\n"

echo "-----Adding-Node-Environment-----"
echo "Fetching Node Version Manager..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
echo "Installing Node @12.19.0..."
nvm install 12.19.0
echo "-----Node-Environment-Added-----\n\n"

echo "-----Sprucing-Up-VIM-----"
echo "Installing Plugin Manager..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Fetching colorscheme..."
git clone https://github.com/morhetz/gruvbox.git
echo "Adding colorscheme Directory..."
mkdir ~/.vim/colors
echo "Adding colorscheme to VIM..."
cp ~/git/gruvbox/colors/gruvbox.vim ~/.vim/colors/
echo "Installing LanguageServers..."
npm i -g typescript
echo "-----VIM-Is-Now-Spruced-----\n\n"

echo "-----Installing-DotFiles-----"
echo "Fetching DotFiles..."
sudo yum install tmux
git clone git@github.com:moogsG/dotfiles.git
echo "Moving DotFiles to user root..."
cp dotfiles/.vimrc ../
cp dotfiles/.bashrc ../
cp dotfiles/.zshrc ../
echo "-----DotFiles-Installed-----\n\n"

echo "-----Pulling-Work-Resources-----"
echo "Cloning Work Repositories..."
git clone git@github.com:meetgradient/hangar-bay.git mono
echo "-----Work-Resources-Pulled-----\n\n"

echo "-----Installing-Resources-----"
echo "Installing Bat..."
wget https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb
sudo yum install -y gdebi
sudo gdebi bat_0.11.0_amd64.deb
echo "-----Work-Resources-Pulled-----\n\n"

echo "-----Installing-ZSH-----"
echo "Installing ZSH..."
sudo yum install -y zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "-----ZSH-Installed-----\n\n"