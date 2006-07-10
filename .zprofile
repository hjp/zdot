#
# $Id: .zprofile,v 1.16 2006-07-10 15:22:01 hjp Exp $
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
