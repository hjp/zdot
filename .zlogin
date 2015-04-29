#
# $Id: .zlogin,v 1.9 2003-08-10 17:09:17 hjp Exp $
#
# this is sourced for login shells after .zshrc
#
mesg y
if [ "`uname`" = "HP-UX" ]
then
	ps -fu $LOGNAME
fi
date
uptime

[ -n "$SSH_AUTH_SOCK" ] &&
	cd ~/zdot &&
	[ -z "`find .ts -mtime -1 2>/dev/null`" ] &&
	git pull &&
	make install &&
	touch .ts
cd ~
