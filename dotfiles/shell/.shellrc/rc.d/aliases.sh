#ls
alias ls='ls --color=auto'
alias ll='ls -la'
alias l.='ls -d .* --color=auto'

#cd
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

#grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#git
alias g='git'

#copying from terminal to the system clipboard
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

#ranger-cd for going to directory via ranger
alias ranger-cd='ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"'
alias r='ranger'
alias rc='ranger-cd'

