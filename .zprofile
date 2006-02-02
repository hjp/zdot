#
# $Id: .zprofile,v 1.15 2006-02-02 16:01:12 hjp Exp $
#
# this is sourced for login shells after .zshenv but before .zshrc
#
umask 022

unset MAILCHECK
export EDITOR=vi

if [ -f /etc/sysconfig/i18n ]
then
    . /etc/sysconfig/i18n
    export LANG
fi

. ~/.zjava

# Set to non-working default values on SUSE Linux.
# I don't use that anyway, so I just unset these values:
unset LESSOPEN LESSCLOSE
