#!/usr/bin/zsh

echo "installing the basic plugins"

# esablish dir
local plugins_dir="$HOME/.config/zsh/zsh-plugins"

# define plugins to download (could abstract these further, but I don't plan on having more..)
local plugins=( "zsh-autosuggestions" "zsh-syntax-highlighting" )

# make plugin dir
if [[ ! -d "$plugins_dir" ]]; then
	mkdir -p $plugins_dir
fi

# download plugins
for plugin in $plugins; do
	echo "Cloning $plugin"
	local plugin_dir="$plugins_dir/$plugin"
	git clone "https://github.com/zsh-users/$plugin" "$plugin_dir"
	# add source to config
	echo "source $plugin_dir/$plugin.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
done

