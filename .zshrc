# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000

#### OBSIDIAN ####

export PATH="$PATH:/usr/bin/obsidian"
alias obsidian="obsidian --appimage-extract-and-run"

#### END ####
#Adds auto completion and vcs_info
autoload -Uz vcs_info compinit

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
source $HOME/.config/zsh/zsh-functions/generate_prompt.zsh

# My right prompt which displays 24hr clock in blue
RPROMPT='%F{blue}[%*]%f'
# my prompt calls my custom_prompt function to display all the good bits
PROMPT='$(generate_prompt $vcs_info_msg_0_)'

source /home/matt/.config/zsh/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/matt/.config/zsh/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
