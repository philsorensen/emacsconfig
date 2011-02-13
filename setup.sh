#!/bin/bash
#
# Setup/copy various files for emacs.
#

# TODO - add cleanup stuff

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


# copy schema files from emacs DATA directory
for file in locate.rnc; do
    cp ${DATA}/schema/${file} schema/
done

# download and covert xhtml 1.0 dtd
trang=http://jing-trang.googlecode.com/files/trang-20091111.zip
xhtml=http://www.w3.org/TR/xhtml1/xhtml1.tgz

if [ ! -f schema/xhtml1-strict.rnc ]; then
	pushd /tmp
	curl -O ${trang}
	curl -O ${xhtml}
	unzip $(basename ${trang})
	tar -xzf $(basename ${xhtml})
	java -jar trang*/trang.jar xhtml*/DTD/xhtml1-strict.dtd ${USER}/schema/xhtml1-strict.rnc
	rm -rf  trang* xhtml*
	popd
fi


# make symbolic links from templates to ~/Templates directory
if [ -d ${HOME}/Templates ]; then
	for file in $(ls -1 templates); do
		ln -sf ${USER}templates/${file} ~/Templates/${file}
	done
fi


# check/create emacs-custom.el and emacs-local.el
if [ ! -r emacs-custom.el ]; then
    touch emacs-custom.el
fi
if [ ! -r emacs-local.el ]; then
    touch emacs-local.el
fi


popd
