
# Check for Homebrew
if test ! $(which nvm)
then
  echo "  Installing nvm"
  curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash
fi

[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh" # Load NVM

# Install Latest Node
nvm install stable
nvm use stable
nvm alias default stable

# Update All
npm update -g
npm install -g grunt
npm install -g gulp
npm install -g bower
npm install -g newman
npm install -g yo
npm install -g coffee-script
npm install -g bless

