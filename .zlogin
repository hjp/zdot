mesg y
if [ "`uname`" = "HP-UX" ]
then
	ps -fu $LOGNAME
fi
date
uptime
[ -n "$SSH_AUTH_SOCK" ] && cd ~/zdot && cvs update -d -P && make install
cd ~
