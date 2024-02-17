# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000

#### PATH ####

export PATH="$PATH:/usr/bin/obsidian"

#### ALIAS #####

# Obsidian
alias obsidian="obsidian --appimage-extract-and-run"

#### END ALIAS ####

# load vcs_info for git
autoload -Uz vcs_info compinit
#### BASIC PROMPT ####
# If you want to go back to normal, audo load prompinit and then you can uncomment out the next two lines..
# promptinit
# prompt walters
#### BASIC PROMPT END ####

# execute vcs_info prior to new command prompt
# This grabs git info and formats the branch name.
# You can find more information in this blog post 
# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# And the git options: 
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information

precmd(){vcs_info}
setopt PROMPT_SUBST
# This is what makes the prompt look cool.
zstyle ':vcs_info:git:*' formats '( %b%)'
custom_prompt() {
  
	#this function just grabs a color for my background. Takes in an arugment of index
	g_bg_color() {  	
		# background colors that I like, change these using ANSI 
		# https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
  		background_colors=(141 219 111 108 210)
		total_colors="${#background_colors[@]}"
		local index="$1"
		local bg_index=$(( $index % $total_colors == 0 ? $total_colors : $index % $total_colors ))			
		echo "$background_colors[bg_index]"
  	}
		
	local prompt_string=""

	# this splits out pwd by / everything
	local dir_levels=(${(@s:/:)PWD})
	
	# this if statement strips "/home/user" and converts it to "~" and then resets the array
	if [[ "/${dir_levels[1]}/${dir_levels[2]}" == "$HOME" ]]; then
		dir_levels[1]="~"
		dir_levels=("${dir_levels[@]:0:1}" "${dir_levels[@]:2}")
	fi

	local dir_length=${#dir_levels[@]}
	
	for ((i=1; i<=$dir_length; i++)); do
		
		# get background and foreground
		local bg_color=$(g_bg_color "$i")  
    		local fg_color="black"            
    		
		# next color
		local next_iter=$(($i + 1))
		local nxt_bg_color=$(g_bg_color "next_iter")
   		
		# current dir string
		local dir="${dir_levels[$i]}"
		
		# my nerd font icon incase I lose it... "" e0b4
		
		# this is just to start adding color and displaying current dir 
		prompt_string+="%K{$bg_color}%F{$fg_color}$dir"
   

    		if [[ $i -eq $dir_length ]]; then	
			# display the git info and the last char for the cmd
			prompt_string+="%f$vcs_info_msg_0_%k%F{$bg_color}%f%k"
			#prompt_string+="%f%k$vcs_info_msg_0_ "
    		else
			#end all the coloring and display the bg_color and icon to make a cool background effect
        		prompt_string+="%f%k%K{$nxt_bg_color}%F{$bg_color}%k%f"
    		fi
	done
	echo $prompt_string
}

# My right prompt which displays 24hr clock in blue
RPROMPT='%F{blue}[%*]%f'
# my prompt calls my custom_prompt function to display all the good bits
PROMPT='$(custom_prompt)'
source /home/matt/.config/zsh/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/matt/.config/zsh/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
