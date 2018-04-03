# custom-af-magic.zsh-theme
# Customized by Corey Gilks
# Original theme: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# Update the IP if we change networks
precmd () {
	eth=$(ifconfig eth0 >> /dev/null 2>&1 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
	wlan=$(ifconfig wlan0 >> /dev/null 2>&1  | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')

	if [ ! -z $eth ]; then
		IP=$eth
	elif [ ! -z $wlan ]; then
		IP=$wlan
	else
		IP='127.0.0.1'
	fi
	# If user is root
	if [[ $UID == 0 || $EUID == 0 ]]; then
		IP_COLOR=$FG[160]
    	DIR_COLOR=$FG[137]
    	PROMPT_SYMBOL=$FG[239]
	else
		IP_COLOR=$FG[078]
		DIR_COLOR=$FG[032]
		PROMPT_SYMBOL=$FG[105]
	fi
}

# primary prompt
PROMPT='$IP_COLOR$IP \
$DIR_COLOR%~\
$(git_prompt_info) \
$PROMPT_SYMBOL%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'

# right prompt
RPROMPT='$my_gray%*%{$reset_color%}%'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

# Refresh the time on the right once a second
#TMOUT=1
#TRAPALRM() {
#    zle reset-prompt
#}
