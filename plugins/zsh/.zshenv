export DOTFILES=$HOME/.dotfiles

# Sets SHELL_PLATFORM to simplified OSTYPE ('linux' or 'macos'). Default is full $OSTYPE
export SHELL_PLATFORM=${SHELL_PLATFORM:=${${OSTYPE//${:-*linux*}/linux}//${:-*darwin*}/macos}}

export LOCATE_PATH=/var/db/locate.database
