mesg y
if [ "`uname`" = "HP-UX" ]
then
	ps -fu $LOGNAME
fi
date
uptime
cd ~/zdot && cvs update -d -P && make install
cd ~
