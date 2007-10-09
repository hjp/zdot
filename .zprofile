#
# $Id: .zprofile,v 1.19 2007-10-09 11:49:11 hjp Exp $
#
# this is sourced for login shells after .zshenv but before .zshrc
#
umask 022

unset MAILCHECK

if [ -f /etc/sysconfig/i18n ]
then
    . /etc/sysconfig/i18n
    export LANG
fi

. ~/.zjava

# Set to non-working default values on SUSE Linux.
# I don't use that anyway, so I just unset these values:
unset LESSOPEN LESSCLOSE

# for TGIF:
if [ -f /etc/X11/rgb.txt ]
then
    export RGBDEF=/etc/X11/rgb.txt
fi

if [ "`uname`" = HP-UX ]
then
    export http_proxy=http://squid.wsr.ac.at:3128/
else 
    unset http_proxy
    for i in http://zeno.hjp.at:3128/ http://squid.wsr.ac.at:3128/
    do
	if http_proxy=$i wget -q -O /dev/null http://www.hjp.at
	then
	    export http_proxy=$i
	    break
	fi
    done
fi
