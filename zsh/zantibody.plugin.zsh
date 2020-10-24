## Packages
if [[ ! -f "$TMPPREFIX/antibody-plugins.sh" ]] {
	{
		# Packaged
		local antibody_plugins=(
			zsh-users/zsh-completions
			psprint/history-search-multi-word
			zsh-users/zsh-autosuggestions
			zdharma/fast-syntax-highlighting
			zsh-users/zsh-history-substring-search
		)

		antibody init
		echo ${(F)antibody_plugins} | antibody bundle
	} | > "$TMPPREFIX/antibody-plugins.sh"
}

source "$TMPPREFIX/antibody-plugins.sh"
