# derimagia does dotfiles

# Mac settings needed to transfer
* Use Fn Keys as standard keys

## TODO

* Add command to dump variable
* Add command to get escaped text (like cat -A. but can we improve it?)
* Improve 'dot' (Maybe use 'blessed'?)
* List all binaries installed with homebrew `print -l /usr/local/Cellar/${^$(brew ls)}/*/bin/*(*N) | cut -d '/' -f '5,8'` (but cleaner). This doesn't take into account keg-only.
