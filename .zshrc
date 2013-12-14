echo ".zshrc: LANG=$LANG"
umask 022
bindkey -v

REPORTTIME=1

alias	amke=make
alias	a=alias
alias	h=history
alias	j=jobs
alias	v=vi
alias	lo=logout
alias	md=mkdir
alias	pop=popd
alias	rd=rmdir
alias	fixsz='set noglob; eval `resize`;unset noglob'
alias	ls='ls	-Fv'
if ls -hld > /dev/null 2>/dev/null
then
    alias	ll='ls	-lFhv'
else
    alias	ll='ls	-lFv'
fi
alias	la='ls	-alsF'
alias	cup='cvs -q update -d -P'
alias	digs='dig +nocomments +nostats +nocmd'
if ack=`whence ack-grep`
then
    alias ack=$ack
fi

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

# and screen sessions shouldn't terminate at all ...
case "$TERM" in
screen)
    unset TMOUT
    ;;
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

# for new style completion:
autoload -U compinit
compinit

utf=`locale -a | grep en_US.utf8`
if [ -n "$utf" ]
then
    # this is a bit of a hack -
    # locale -a advertises the locale as "en_US.utf8",
    # but the glibc accepts both "en_US.utf8" and
    # "en_US.UTF-8" and xterm recogizes only the latter.
    # So we explicitely set the latter, even though that's
    # not the canonical name and may break some day.
    # 
    case "`uname -sr`" in
    Linux*)
	LANG=en_US.UTF-8
	;;
    HP-UX*)
	# UTF-8 locale on HP-UX is broken
	LANG=en_US.iso88591
	;;
    *)
	LANG=en_US.utf8
	;;
    esac
else 
    # fall back to latin 1.
    LANG=en_US.iso88591
fi
export LANG
case "$LANG" in
*.iso88591)
	export LESSCHARSET=latin1
	export NLS_LANG=american_america.WE8ISO8859P1
	;;
*.UTF-8)
	export NLS_LANG=american_america.UTF8
	;;
esac
