#!/bin/bash
#
# Setup/copy various files for emacs.
#

# TODO - add cleanup stuff

# make sure we are in the right directory 
pushd $(dirname $(readlink -fn $0))

# move any existing .emacs, .emacs.el, or .emacs.elc
for file in .emacs .emacs.el .emacs.elc; do
    if [ -f ${HOME}/${file} ]; then 
	mv ${HOME}/${file} ${HOME}/${file}.old
    fi
done

# check/create emacs-custom.el and emacs-local.el
if [ ! -r emacs-custom.el ]; then
    touch emacs-custom.el
fi
if [ ! -r emacs-local.el ]; then
    touch emacs-local.el
fi

popd
