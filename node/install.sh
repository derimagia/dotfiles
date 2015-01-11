
# Check for Homebrew
if test ! $(which nvm)
then
  echo "  Installing nvm"
  curl https://raw.githubusercontent.com/creationix/nvm/v0.22.0/install.sh | bash
fi

# Install Latest Node
nvm install stable
nvm use stable
nvm alias default stable

# Update All
npm update -g
npm install -g grunt
npm install -g bower
npm install -g newman
npm install -g yo
