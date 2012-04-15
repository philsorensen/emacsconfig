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

# check/create downloads directory
if [ ! -d downloads ]; then
    mkdir downloads
fi


#
# NXML setup
#

# patch xmltok.el from nxhtml-mode
nxhtml=http://ourcomments.org/Emacs/DL/elisp/nxhtml/zip/nxhtml-2.08-100425.zip

if [ ! -r xmltok.el ]; then
    pushd downloads
    if [ ! -r $(basename ${nxhtml}) ]; then
	curl -O ${nxhtml}
    fi
    unzip -c $(basename ${nxhtml}) nxhtml/etc/schema/nxml-erb.patch >/tmp/xmltok.patch
    popd

    if [ -r ${DATA}../lisp/nxml/xmltok.el.gz ]; then
        cp ${DATA}../lisp/nxml/xmltok.el.gz .
        gunzip xmltok.el.gz
    else
        cp ${DATA}../lisp/nxml/xmltok.el .
    fi
    patch </tmp/xmltok.patch
    rm xmltok.el.orig /tmp/xmltok.patch
fi

# copy schema files from emacs DATA directory
for file in locate.rnc; do
    cp ${DATA}/schema/${file} schema/
done

# download xhtml5.rnc and patch from git://github.com/validator/schemas.git
if [ ! -r schema/xhtml5.rnc ]; then
    pushd schema
    curl -O https://raw.github.com/validator/schemas/gh-pages/xhtml5.rnc

    cat >/tmp/xhtml5.rnc.patch <<EOF
--- xhtml5.rnc.orig	2012-04-07 21:57:15.438857554 -0400
+++ xhtml5.rnc	2012-04-07 22:44:58.056025877 -0400
@@ -177,7 +177,8 @@
     # REVISIT move style to a module and bundle tabindex with ARIA
     common.attrs.accesskey =
       attribute accesskey { common.data.keylabellist }
-    common.attrs.other = empty
+    common.attrs.other = common.attrs.data
+      include "../html5-data.rnc"
     # #####################################################################
     
     ##  Common Datatypes                                                  #
EOF
    patch xhtml5.rnc </tmp/xhtml5.rnc.patch
    rm /tmp/xhtml5.rnc.patch

    popd
fi


#
# Other setup
#

# make symbolic links from templates to ~/Templates directory
if [ -d ${HOME}/Templates ]; then
    for file in $(ls -1 templates); do
	cp ${USER}templates/${file} ~/Templates/${file}
	chmod 444 ~/Templates/${file}
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
