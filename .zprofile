#
# $Id: .zprofile,v 1.9 2003-08-10 17:09:17 hjp Exp $
#
# this is sourced for login shells after .zshenv but before .zshrc
#
umask 022
echo TERM=$TERM
eval `echo TERM=$TERM`
if [ -f "$EXEC" ] 
then
	source $EXEC
fi
if [ -f /usr/local/bin/findsock ]
then
	sock=`findsock $$`
fi
if [ -z "$sock" ]
then
	vhost=`hostname`
else 
	vhost="$sock"
fi
vhost=`echo "$vhost" | cut -d . -f 1`
RECHNER=$vhost

if [ -f /etc/oraprofile ]
then
    . /etc/oraprofile
fi

unset MAILCHECK

