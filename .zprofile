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

