alias composer="php -n =composer"

export COMPOSER_HOME=~/.composer

path=(
    $COMPOSER_HOME/vendor/bin
    $path
)
