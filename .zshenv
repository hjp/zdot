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
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
setopt RMSTARSILENT
setopt NO_PROMPT_CR

# fix problem with nfs
pushd ~
HOME=`pwd`
popd

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
ETC_PATH=/usr/local/etc:/usr/etc:/etc:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/samba/bin
BIN_PATH=/usr/softbench/bin:/usr/vue/bin:/usr/bin/X11:/bin:/usr/bin:/usr/local/bin:/usr/local/bin/X11

ALL_PATH=$PRIVATE_PATH:$ETC_PATH:$BIN_PATH:$PATH
NEW_PATH=""

for i in ${(s/:/)ALL_PATH}
do
	if test -d "$i"
	then
		if echo "$NEW_PATH" | egrep '(^|:)'"$i"'(:|$)' > /dev/null
		then
		else
			if test -z "$NEW_PATH"
			then
				NEW_PATH=$i
			else
				NEW_PATH=$NEW_PATH:$i
			fi
		fi
	fi
done

export PATH=$NEW_PATH
export LANG=american.iso88591
export LC_COLLATE=american.iso88591@nofold
if test "`uname`" = HP-UX
then
    # need to set that explicitely on HP-UX. MESZ isn't standard, so
    # I do it ONLY on HP-UX
    export TZ=MEZ-1MESZ
fi
if [ -x /usr/bin/less ]
then
	export PAGER=/usr/bin/less
elif [ -x /usr/local/bin/less ]
then
	export PAGER=/usr/local/bin/less
fi
export XAUTHORITY=$HOME/.Xauthority
export CVSROOT=/nfs/wsrdb/usr/local/src/master
