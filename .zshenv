
unsetopt BGNICE
setopt CHASELINKS
setopt AUTO_CD
setopt AUTO_PUSHD
setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY
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
export LESSCHARSET=latin1
export PARINIT=q1
export PARBODY=_A_a

if [ -f /etc/oraenv ]
then
    . /etc/oraenv
fi

# set PATH to direcories *I* want.
PRIVATE_PATH=$HOME/bin/scripts:$HOME/bin:$HOME/public_html/bin:$HOME/pgreplica/bin
ETC_PATH=/usr/sbin:/sbin:/opt/omni/sbin:/opt/omni/lbin:/var/qmail/bin:/usr/local/ssl/bin:/usr/adm/acct/wsr/bin:/opt/tusc/bin:/usr/local/pgsql/bin
LOCAL_PATH=/usr/local/arm-linux/bin:/usr/local/sbin:/usr/local/samba/bin:/usr/local/bin:/usr/local/bin/X11:/usr/local/povray3/bin:/usr/local/majordomo/bin:/usr/local/vnc_x86_linux_2.0
BIN_PATH=/usr/bin/X11:/bin:/usr/bin:/usr/ccs/bin:/usr/openwin/bin:/opt/kde/bin:/opt/perl5/bin:/opt/Office51/bin:/usr/games:/usr/contrib/bin
JAVA_PATH=/usr/java/j2sdk1.4.0/bin:/usr/local/jdk1.2.2/bin:/usr/java1.2/bin:/usr/local/jdk1.2/bin:/usr/local/jdk117_v3/bin:/usr/local/jdk1.1.6/bin:/usr/local/java/bin
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

export EDITOR=`echo =vi`

if [ -r /etc/MANPATH ]
then
	MANPATH=`cat /etc/MANPATH`:$MANPATH
else
	ALL_PATH=/usr/local/qmail/man:/usr/man:/usr/local/man:/usr/X11R6/man:/usr/share/man:/usr/local/pgsql/man
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
	MANPATH=$NEW_PATH
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
export NLS_LANG=american_america.WE8ISO8859P1


if [ -x /usr/bin/less ]
then
	export PAGER="/usr/bin/less -i"
elif [ -x /usr/local/bin/less ]
then
	export PAGER="/usr/local/bin/less -i"
fi
if [ -z "$XAUTHORITY" ] 
then
	export XAUTHORITY=$HOME/.Xauthority
fi

case "$HOST" in 
   *.*)
	export FQDN=$HOST
	;;
   *)
	export FQDN=`fqdn`
	;;
esac

case "$FQDN" in
   *.wsr.ac.at)
	export LPDEST=wsrplj51
	;;
esac

case "$FQDN" in
   braveheart.wsr.ac.at)
	export CVSROOT=/usr/local/src/master
	;;
   *.luga.at|*.luga.or.at)
	export CVSROOT=cvs.luga.at:/home/cvs
	;;
   *)
	export CVSROOT=cvs.wsr.ac.at:/usr/local/src/master
	;;
esac

for i in /usr/local/bin/ssh /usr/bin/ssh
do
    if [ -x $i ]
    then
	export CVS_RSH=$i
    fi
done

if test "`uname`" = Linux
then
    limit coredumpsize 64M
fi

case "$FQDN" in
   teal.h.hjp.at|SiKitu.wsr.ac.at)
	export MAIL=$HOME/Maildir
	;;
   *.wsr.ac.at)
	;;
esac

case "$FQDN" in
   *.h.hjp.at)
	export NNTPSERVER=teal.h.hjp.at
	;;
   SiKitu.wsr.ac.at)
	export NNTPSERVER=SiKitu.wsr.ac.at
	;;
   *.wsr.ac.at)
	export NNTPSERVER=news.wsr.ac.at
	;;
esac

case "$FQDN" in
   *.h.hjp.at)
	export http_proxy=http://teal.h.hjp.at:3128/
	;;
   SiKitu.wsr.ac.at)
	export http_proxy=http://SiKitu.wsr.ac.at:3128/
	;;
   *.h.hjp.at)
	export http_proxy=http://teal.h.hjp.at:3128/
	;;
   *.wsr.ac.at)
	export http_proxy=http://squid.wsr.ac.at:3128/
	;;
esac



case "$FQDN" in
   enkur.wsr.ac.at)
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/local/mnemonic/lib:/usr/local/mnemonic/lib/msg:/usr/local/lib
	;;
   melange.wsr.ac.at|spirit.luga.at|chthon.h.hjp.at|posbi.wsr.ac.at|wsrgeh.wsr.ac.at|braveheart.wsr.ac.at|dialog.wsr.ac.at)
	export LD_LIBRARY_PATH=/usr/local/lib
	;;
   posbi.wsr.ac.at)
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/local/lib
	;;
   *.wsr.ac.at)
	;;
   trout.adcon.at|teal.h.hjp.at)
	export LD_LIBRARY_PATH=$HOME/wrk/a840sw/ia32/lib:/usr/local/lib
	;;
esac


export TABLE_DELIMITER='|'

ALL_PATH=.:/usr/local/java/classes:$ORACLE_HOME/jdbc/lib/classes111.zip:/usr/java1.2/lib/tools.jar:/usr/local/jswdk-1.0.1/lib/servlet.jar:/usr/local/java/lib/Tidy.jar:/usr/local/roxen/2.1/roxen/server/java/classes/servlet.jar
NEW_PATH=""

for i in ${(s/:/)ALL_PATH}
do
	if test -r "$i"
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

export CLASSPATH=$NEW_PATH

if [ -d /usr/local/pgsql/data/ ]
then
	export PGDATA=/usr/local/pgsql/data/
fi

export MAKEFLAGS="-I $HOME/include"
