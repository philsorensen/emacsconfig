#!/bin/bash
#
# Setup/copy various files for emacs.
#


# read a few variables from emacs
DATA=$(emacs --batch --execute "(message data-directory)" 2>&1 | tail -1)
USER=$(emacs --batch --execute "(message (expand-file-name user-emacs-directory))" 2>&1 | tail -1)


# move to the basedir and make sure it is the user-emacs-directory 
pushd $(dirname $(readlink -fn $0))
if [ "${PWD}/" != "${USER}" ]; then
    echo "Must clone repository to emacs user-emacs-directory (${USER})"
fi

# move any existing .emacs, .emacs.el, or .emacs.elc
for file in .emacs .emacs.el .emacs.elc; do
    if [ -f ${HOME}/${file} ]; then 
	mv ${HOME}/${file} ${HOME}/${file}.old
    fi
done


#
# Other setup
#

# check/create emacs-custom.el and emacs-local.el
if [ ! -r emacs-custom.el ]; then
    touch emacs-custom.el
fi
if [ ! -r emacs-local.el ]; then
    touch emacs-local.el
fi


popd
