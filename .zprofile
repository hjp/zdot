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

# I don't understand this any more.
# looks like a nop to me.
if [ -n "" -a  -z "$SSH_AUTH_SOCK" -a -f "$HOME/.ssh/identity" ] && tty -s
then
    eval `ssh-agent`
    ssh-add
fi
   
if [ -f /etc/oraprofile ]
then
    . /etc/oraprofile
fi


