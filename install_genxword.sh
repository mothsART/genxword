#!/bin/sh
# Script to install genxword, which depends on Python (2.7 or 3) and Pycairo.

set -e
ERROR_MESSAGE="$(tput bold)$(tput setaf 1)An error occurred. \
Please read the output above to see what the problem is.$(tput sgr0)\n"
MAN_DIR=/usr/share/man/man6

printf "Just press Enter to use the Python 2.7 version.\n\
To use the Python 3 version, press any key and then Enter.\n"
read PYVERSION
if [ -z $PYVERSION ]; then
    python2.7 setup.py install || { printf "$ERROR_MESSAGE"; exit 1; }
    APP_NAME=genxword
else
    python3 setup.py install || { printf "$ERROR_MESSAGE"; exit 1; }
    APP_NAME=genxword-py3
fi
printf "Installing the $APP_NAME program\n"
cp $APP_NAME /usr/bin/ && chmod 755 /usr/bin/$APP_NAME || { printf "$ERROR_MESSAGE"; exit 1; }

cd man
printf "Installing the man page for $APP_NAME\n"
cp $APP_NAME.6 $MAN_DIR && gzip -f $MAN_DIR/$APP_NAME.6 || { printf "$ERROR_MESSAGE"; exit 1; }

printf "$(tput setaf 2)The program $APP_NAME has been successfully installed.\n\
Run $APP_NAME -h for basic info about the program or read the man page for further options.$(tput sgr0)\n"