if test ! $(which rvm)
then
  echo "  Installing RVM for you."
  curl -sSL https://get.rvm.io | bash -s stable --ruby
fi

# Bundler
gem install bundler

# Misc
gem install bropages

# Compass/Sass
gem install compass
gem install bootstrap-sass
gem install zurb-foundation
