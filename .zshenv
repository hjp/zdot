
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
export PGPPATH=~/.pgp
export PARINIT=q1
export PARBODY=_A_a

if [ -f $HOME/etc/oraenv ] 
then 
	. $HOME/etc/oraenv
elif [ -f /etc/oraenv ]
then
	. /etc/oraenv
fi

# set PATH to direcories *I* want.
PRIVATE_PATH=$HOME/bin/hosts:$HOME/bin/scripts:$HOME/bin:$HOME/public_html/bin:$HOME/pgreplica/bin
ETC_PATH=/usr/sbin:/sbin:/opt/omni/sbin:/opt/omni/lbin:/var/qmail/bin:/usr/local/ssl/bin:/usr/adm/acct/wsr/bin:/opt/tusc/bin:/usr/local/pgsql/bin
LOCAL_PATH=/usr/local/arm-linux/bin:/usr/local/sbin:/usr/local/samba/bin:/usr/local/bin:/usr/local/bin/X11:/usr/local/povray3/bin:/usr/local/majordomo/bin:/usr/lib/majordomo/bin:/usr/local/vnc_x86_linux_2.0:/usr/local/rrdtool-1.0.35/bin:/usr/local/OpenOffice.org1.0.2/program
BIN_PATH=/usr/bin/X11:/bin:/usr/bin:/usr/ccs/bin:/usr/openwin/bin:/opt/kde/bin:/opt/perl5/bin:/opt/Office51/bin:/usr/games:/usr/contrib/bin
ORACLE_PATH=$ORACLE_HOME/bin

if [ -r /etc/PATH ]
then
	PATH=`cat /etc/PATH`:$PATH
fi

ALL_PATH=$PRIVATE_PATH:$LOCAL_PATH:$ETC_PATH:$BIN_PATH:$ORACLE_PATH:$PATH
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
	ALL_PATH=/usr/local/qmail/man:/usr/man:/usr/local/man:/usr/X11R6/man:/usr/share/man:/usr/local/pgsql/man:/var/qmail/man:/usr/local/rrdtool-1.0.35/man
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
Linux*)
	export LC_COLLATE=POSIX
	if [ -z "$LANG" ]
	then
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
		LANG=en_US.UTF-8
	    else 
		# fall back to latin 1.
		LANG=en_US.iso88591
	    fi
	    export LANG
	fi
	# export LC_TIME=de_AT # don't remember what that was for
	;;
esac

case "$LANG" in
*.iso88591)
	export LESSCHARSET=latin1
	export NLS_LANG=american_america.WE8ISO8859P1
	;;
*.UTF-8)
	#export LESSCHARSET=latin1
	export NLS_LANG=american_america.UTF8
	# export LC_TIME=de_AT.UTF-8
	;;
esac

export NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS'


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
	export LPDEST=wsrpl1
	;;
esac

case "$FQDN" in
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
	export RSYNC_RSH=$i
    fi
done

if test "`uname`" = Linux
then
    limit coredumpsize 64M
fi

case "$FQDN" in
   teal.hjp.at)
	export MAIL=$HOME/Maildir
	;;
   *.wsr.ac.at)
	;;
esac

case "$FQDN" in
   *.hjp.at)
	export NNTPSERVER=teal.hjp.at
	;;
   *.wsr.ac.at)
	export NNTPSERVER=news.wsr.ac.at
	;;
esac

case "$FQDN" in
   *.hjp.at)
	export http_proxy=http://teal.hjp.at:3128/
	;;
   samkar.wsr.ac.at|wsrgeh.wsr.ac.at|laire.wsr.ac.at)
	unset http_proxy
	;;
   *.wsr.ac.at)
	export http_proxy=http://dobby.wsr.ac.at:3128/
	;;
esac



case "$FQDN" in
   wsrgeh.wsr.ac.at|coney.wsr.ac.at|bernon.wsr.ac.at)
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/local/lib
	;;
   melange.wsr.ac.at|spirit.luga.at|chthon.h.hjp.at|posbi.wsr.ac.at|braveheart.wsr.ac.at|dialog.wsr.ac.at|samkar.wsr.ac.at|yoyo.hjp.at|yoyo.wsr.ac.at|localhost.localdomain)
	export LD_LIBRARY_PATH=/usr/local/lib
	;;
   *.wsr.ac.at)
	;;
esac


export TABLE_DELIMITER='|'

if [ -d /usr/local/pgsql/data/ ]
then
	export PGDATA=/usr/local/pgsql/data/
fi

export MAKEFLAGS="-I $HOME/include"
if [ -d /usr/local/www ]
then
    export HOME_WWW=/usr/local/www
elif [ -d /home/www ]
then
    export HOME_WWW=/home/www
fi
