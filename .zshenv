
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

SAVEHIST=100
HISTSIZE=$SAVEHIST
HISTFILE=~/.zhistory
export PGPPATH=~/.pgp
export PARINIT=q1
export PARBODY=_A_a
export DEBEMAIL=hjp@hjp.at
export export ACK_COLOR_FILENAME='blue on_white'


# don't rely on a sane path at this point:
for i in /usr/bin/preppath /usr/local/bin/preppath
do
    if [ -x $i ]
    then
    	preppath=$i
	break;
    fi
done

if [ -n "$preppath" ]
then
    if [ -r /etc/PATH ]
    then
	PATH=$($preppath $(cat /etc/PATH) )
    fi

    # first prepend important stuff - in order of increasing priority:

    PATH=`$preppath -c /usr/bin/X11:/usr/games:/usr/contrib/bin`
    PATH=`$preppath -c /bin:/usr/bin`
    # openoffice 1.1 is in /usr/bin, so we need to prepend 
    # oo2.0 before it:
    PATH=`$preppath -c /opt/openoffice.org2.0/program`
    PATH=`$preppath -c /usr/sbin:/sbin:/opt/omni/sbin:/opt/omni/lbin:/var/qmail/bin:/usr/local/ssl/bin:/opt/tusc/bin`
    PATH=`$preppath -c /usr/local/sbin:/usr/local/bin`
    PATH=`$preppath -c /usr/local/mysql-5.1.40-hpux11.11-hppa2.0w-64bit/bin`
    PATH=`$preppath -c $HOME/bin/hosts:$HOME/bin`

    # then append less important stuff
    PATH=`apppath -c /opt/Navisphere/bin`
    PATH=`apppath -c /usr/local/majordomo/bin:/usr/lib/majordomo/bin:/usr/local/vnc_x86_linux_2.0:/usr/local/rrdtool-1.0.35/bin`
    PATH=`apppath -c /usr/local/www/offline/devel.fiw/bin`
fi

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
	export NLS_LANG=american_america.UTF8
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
	export LPDEST=wsrcolor
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
	export NNTPSERVER=zeno.hjp.at
	;;
   *.wsr.ac.at)
	export NNTPSERVER=news.wsr.ac.at
	;;
esac



case "$FQDN" in
   wsrgeh.wsr.ac.at|coney.wsr.ac.at|bernon.wsr.ac.at|ariel.wsr.ac.at|chthon.h.hjp.at|posbi.wsr.ac.at|braveheart.wsr.ac.at|dialog.wsr.ac.at|samkar.wsr.ac.at|yoyo.hjp.at|yoyo.wsr.ac.at|localhost.localdomain|teal.hjp.at)
	export LD_LIBRARY_PATH=/usr/local/lib
	;;
   tanstaafl.wsr.ac.at|pashkan.wsr.ac.at)
	export LD_LIBRARY_PATH=`preppath -v LD_LIBRARY_PATH /usr/local/lib`
	;;
    mri.wsr.ac.at|hrunkner.hjp.at)
        export LD_LIBRARY_PATH=`apppath -v LD_LIBRARY_PATH /usr/lib/jni`
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

if [ -f $HOME/etc/oraenv ] 
then 
	. $HOME/etc/oraenv
elif [ -f /etc/oraenv ]
then
	. /etc/oraenv
fi
if [ -n "$ORACLE_HOME" ]
then
    PATH=`apppath "$ORACLE_HOME/bin"`
fi

case "$FQDN" in
   shalmaneser.wsr.ac.at)
	export WZRP_CONN=~/.dbi/fiwssd
	;;
   pashkan.wsr.ac.at)
	export WZRP_CONN=~/.dbi/fiwdevel
	;;
   mri.wsr.ac.at)
	export WZRP_CONN=~/.dbi/fiwdevel
	;;
   algernon.wsr.ac.at)
	export WZRP_CONN=~/.dbi/fiwssd
	;;
esac

case "$FQDN" in
   tanstaafl.wsr.ac.at)
	export PERL5LIB=/home/hjp/wrk/wzrp-tng/import/lib:/home/hjp/wrk/wzrp-tng/import/wiiw/lib:/usr/local/www/offline/devel.fiw/lib/perl5
	PATH=`apppath /usr/local/www/offline/devel.fiw/bin`
	;;
   shalmaneser.wsr.ac.at)
	export  PERL5LIB=/home/hjp/wrk/wzrp-tng/import/lib:/home/hjp/wrk/wzrp-tng/import/wiiw/lib:/usr/local/www/offline/dal.fiw/lib/perl5
	PATH=`apppath /usr/local/www/offline/dal.fiw/bin`
	;;
   pashkan.wsr.ac.at)
	;;
esac

case "$FQDN" in
   algernon.wsr.ac.at)
	export PGHOST=$FQDN
        export PGUSER=fiw
	;;
   pashkan.wsr.ac.at)
	export PGHOST=$FQDN
        export PGUSER=fiw
	;;
esac

case "$FQDN" in
   *.wsr.ac.at)
	export LOCALDOMAIN="wsr.ac.at hjp.at"
	;;
esac

if [ -d $HOME/go ]
then
    export GOROOT=$HOME/go
    export GOOS=linux
    case `uname  -m` in
    x86_64)
        export GOARCH=amd64
        ;;
    *)
        export GOARCH=386
    esac
fi
