umask 022
bindkey -v

alias	amke=make
alias	arm=/bin/rm
alias	a=alias
alias	h=history
alias	j=jobs
alias	v=vi
alias	lo=logout
alias	md=mkdir
alias	pop=popd
alias	rd=rmdir
alias	ball='pd /usr/local/projects/ball; source s'
alias	srcsrv='pd ~/wrk/srcservice/clients/exp'
alias	fixsz='set noglob; eval `resize`;unset noglob'
alias	ls='ls	-F'
alias	ll='ls	-lF'
alias	la='ls	-alsF'
alias	lc='ls	-l *.c'
alias	ts='tail /usr/spool/mqueue/syslog'
alias	train='pd ~/wrk/mars/train'

namedir(){
	eval "$1=~+"
	: ~$1
}

pd(){
	if [[ $# = 0 ]]
	then 
		pushd +1
	else
		pushd "$@"
	fi
	namedir `basename $PWD | tr -cd 'A-Za-z0-9'`
}

setenv(){
	$1=$2
	export $1
}

cls()	{ clear; true }

source ~/.znewterm
