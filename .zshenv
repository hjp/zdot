date
unsetopt BGNICE
setopt CHASELINKS
setopt AUTO_CD
setopt AUTO_PUSHD
setopt EXTENDED_GLOB
setopt LIST_TYPES
unsetopt MARKDIRS
unsetopt MENU_COMPLETE
unsetopt NO_CLOBBER
setopt NOTIFY
setopt NUMERIC_GLOB_SORT
setopt PRINT_EXIT_VALUE
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
setopt RMSTARSILENT
setopt NO_PROMPT_CR

# fix problem with nfs
# Does this still work? I have deleted it at home.
# in any case I probably don't need it.
pushd ~
HOME=`pwd`
popd

setopt PUSHD_IGNORE_DUPS

fpath=(~/bin/func)
SAVEHIST=100
HISTSIZE=$SAVEHIST
HISTFILE=~/.zhistory
REPORTTIME=1
TMOUT=0
export PGPPATH=~/.pgp
export EDITOR=`echo =vi`
export LESSCHARSET=latin1
export PARINIT=q1
export PARBODY=_A_a
export LPDEST=wsrplj51

# set PATH to direcories *I* want.
PRIVATE_PATH=/usr/local/alpha/mt/bin:$HOME/bin/scripts:$HOME/bin
ETC_PATH=/usr/local/etc:/usr/etc:/etc:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/samba/bin:/opt/omni/sbin:/opt/omni/lbin
BIN_PATH=/usr/local/bin:/usr/softbench/bin:/usr/vue/bin:/usr/bin/X11:/bin:/usr/bin:/usr/local/bin/X11
if [ -r /etc/PATH ]
then
	PATH=`cat /etc/PATH`:$PATH
fi

ALL_PATH=$PRIVATE_PATH:$ETC_PATH:$BIN_PATH:$PATH
NEW_PATH=""

date
for i in ${(s/:/)ALL_PATH}
do
	if test -d "$i"
	then
		case "$NEW_PATH" in
		$i:*|*:$i|*:$i:*) ;;
		*)
			if test -z "$NEW_PATH"
			then
				NEW_PATH=$i
			else
				NEW_PATH=$NEW_PATH:$i
			fi
		esac
	fi
done

export PATH=$NEW_PATH
date

if [ -r /etc/MANPATH ]
then
	MANPATH=`cat /etc/MANPATH`:$MANPATH
fi


case "`uname -sr`" in
HP-UX*09.*)
	export LANG=${LANG:-american.iso88591}
	export LC_COLLATE=${LC_COLLATE:-american.iso88591@nofold}
	;;
HP-UX*10.*)
	export LANG=${LANG:-C.iso88591}
	;;
esac
if test "`uname`" = HP-UX
then
    # need to set that explicitely on HP-UX. MESZ isn't standard, so
    # I do it ONLY on HP-UX
    export TZ=MEZ-1MESZ
fi
if [ -x /usr/bin/less ]
then
	export PAGER="/usr/bin/less -i"
elif [ -x /usr/local/bin/less ]
then
	export PAGER="/usr/local/bin/less -i"
fi
export XAUTHORITY=$HOME/.Xauthority

case "$HOST" in
   wsrk.wsr.ac.at)
	export CVSROOT=/u/cvs
	;;
   SiKitu.wsr.ac.at)
	export CVSROOT=wsrx.wsr.ac.at:/nfs/wsrk/u/cvs
	;;
   *.wsr.ac.at)
	export CVSROOT=/nfs/wsrk/u/cvs
	;;
esac
if test "`uname`" = Linux
then
    limit coredumpsize 64M
fi
case "$HOST" in
   SiKitu.wsr.ac.at)
	export MAIL=$HOME/Maildir
	;;
   *.wsr.ac.at)
	;;
esac
MANPATH=/usr/local/qmail/man:/usr/man:/usr/local/man:/usr/X11R6/man
export MANPATH
date
