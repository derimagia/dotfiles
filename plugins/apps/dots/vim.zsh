#!/usr/bin/env zsh

vim +PlugInstall +qall

if is_macos; then
  function download_font() {
    local font_dir="$HOME/Library/Fonts"
    local font_name='FuraMono-Regular.otf'
    local font_path="$font_dir/$font_name"

    if [[ ! -f "$font_path" ]]; then
      local font_repo="https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts"
      local font_url="$font_repo/FiraMono/Regular/complete/Fura%20Mono%20Regular%20for%20Powerline%20Nerd%20Font%20Complete.otf"

      ink -l -c magenta -- "-- Installing Font to '$font_path'"

      wget -qO "$font_path" "$font_url"
      fc-cache
    fi
  }
  download_font
fi
