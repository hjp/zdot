setopt ignoreeof
mesg y
if [ "`uname`" = "HP-UX" ]
then
	ps -fu $LOGNAME
fi
date
