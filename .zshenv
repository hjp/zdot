setopt APPEND_HISTORY
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

if [ -f /etc/oraenv ]
then
    . /etc/oraenv
fi

# set PATH to direcories *I* want.
PRIVATE_PATH=/usr/local/alpha/mt/bin:$HOME/bin/scripts:$HOME/bin:$HOME/public_html/bin
ETC_PATH=/usr/etc:/etc:/usr/sbin:/sbin:/opt/omni/sbin:/opt/omni/lbin:/usr/local/qmail/bin:/usr/local/ssl/bin:/usr/adm/acct/wsr/bin
LOCAL_PATH=/usr/local/etc:/usr/local/sbin:/usr/local/samba/bin:/usr/local/bin:/usr/local/bin/X11:/usr/local/povray3/bin
BIN_PATH=/usr/softbench/bin:/usr/vue/bin:/usr/bin/X11:/bin:/usr/bin:/usr/ccs/bin:/usr/openwin/bin:/opt/kde/bin:/opt/perl5/bin
JAVA_PATH=/usr/local/jdk1.1.6/bin:/usr/local/jdk1.1.1/bin:/usr/local/java/bin
ORACLE_PATH=$ORACLE_HOME/bin

if [ -r /etc/PATH ]
then
	PATH=`cat /etc/PATH`:$PATH
fi

ALL_PATH=$PRIVATE_PATH:$LOCAL_PATH:$ETC_PATH:$JAVA_PATH:$BIN_PATH:$ORACLE_PATH:$PATH
NEW_PATH=""

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

if [ -r /etc/MANPATH ]
then
	MANPATH=`cat /etc/MANPATH`:$MANPATH
else
	MANPATH=/usr/local/qmail/man:/usr/man:/usr/local/man:/usr/X11R6/man
fi
export MANPATH


case "`uname -sr`" in
HP-UX*09.*)
	export LANG=${LANG:-american.iso88591}
	export LC_COLLATE=${LC_COLLATE:-american.iso88591@nofold}
	;;
HP-UX*10.*)
	export LANG=${LANG:-C.iso88591}
        export TZ=MEZ-1MESZ
	;;
esac

if [ -x /usr/bin/less ]
then
	export PAGER="/usr/bin/less -i"
elif [ -x /usr/local/bin/less ]
then
	export PAGER="/usr/local/bin/less -i"
fi
export XAUTHORITY=$HOME/.Xauthority

case "$HOST" in 
   *.*)
	export FQDN=$HOST
	;;
   *)
	export FQDN=`fqdn`
	;;
esac

case "$FQDN" in
   calypso.wsr.ac.at)
	export CVSROOT=/usr/local/src/master
	export CVS_RSH=/usr/local/bin/ssh
	;;
   *.luga.at|*.luga.or.at)
	export CVSROOT=cvs.luga.at:/usr/local/src/master
	export CVS_RSH=/usr/local/bin/ssh
	;;
   *)
	export CVSROOT=cvs.wsr.ac.at:/usr/local/src/master
	export CVS_RSH=/usr/local/bin/ssh
	;;
esac
if test "`uname`" = Linux
then
    limit coredumpsize 64M
fi

case "$FQDN" in
   SiKitu.wsr.ac.at)
	export MAIL=$HOME/Maildir
	;;
   *.wsr.ac.at)
	;;
esac

case "$FQDN" in
   SiKitu.wsr.ac.at)
	export NNTPSERVER=SiKitu.wsr.ac.at
	;;
   *.wsr.ac.at)
	export NNTPSERVER=news.wsr.ac.at
	;;
esac

case "$FQDN" in
   SiKitu.wsr.ac.at)
	export http_proxy=http://SiKitu.wsr.ac.at:3128/
	;;
   *.wsr.ac.at)
	export http_proxy=http://squid.wsr.ac.at:3128/
	;;
esac



case "$FQDN" in
   enkur.wsr.ac.at)
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib
	;;
   melange.wsr.ac.at|spirit.luga.or.at|chthon.wsr.ac.at|posbi.wsr.ac.at)
	export LD_LIBRARY_PATH=/usr/local/lib
	;;
   *.wsr.ac.at)
	;;
esac

export CLASSPATH=.:/usr/local/java/classes
