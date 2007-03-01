umask 022
bindkey -v

REPORTTIME=1

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
alias	fixsz='set noglob; eval `resize`;unset noglob'
alias	ls='ls	-F'
if ls -hld > /dev/null 2>/dev/null
then
    alias	ll='ls	-lFh'
else
    alias	ll='ls	-lF'
fi
alias	la='ls	-alsF'
alias	cup='cvs -q update -d -P'
alias	digs='dig +nocomments +nostats +nocmd'

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
	namedir $(echo $(basename $PWD | tr -cd 'A-Za-z0-9_') | sed -e 's/^[0-9]/_&/')
}

setenv(){
	$1=$2
	export $1
}

harden(){
	cp -p "$1" .harden.$$ && mv .harden.$$ "$1"
}

dup(){
	mv $1 $1.orig && cp -p $1.orig $1
}

cls()	{ clear; true }

source ~/.znewterm

# assume pseudo terminals are from a "safe" terminal
# other terminals are probably from a console and should
# auto-logout after some time.
case `tty` in
/dev/pts/*)
    TMOUT=14400
    ;;
*)
    TMOUT=3600
esac

if [ -z "$EDITOR" ]
then
    export EDITOR=vi
fi

# prepend local function dir if we have one.
#
# Important: Don't clobber FPATH. It's needed for completion and usually
# contains a lot of directories (at least on Debian systems) and you
# don't want to recreate that mess manually.
if [ -d ~/bin/func ]
then
    FPATH=`preppath -v FPATH ~/bin/func`
fi
