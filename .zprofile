#
# $Id: .zprofile,v 1.22 2012-10-19 11:03:15 hjp Exp $
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

limit coredumpsize unlimited
