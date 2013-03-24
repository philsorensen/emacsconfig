;;
;; init.el file
;;
;; This file is in the .emacs.d directory where it is under git.  You need
;; make sure that there is either no ~/.emacs file or the this file is
;; linked to ~/.emacs.
;;
;; Current file is designed for versions 23.2 (possibly later).  Variables
;; and functions should be checked for new defaults, additions, etc. when
;; old versions are dropped or added.
;;


;; Add ~/.emacs.d/ ( user-emacs-directory) to search path
;;
(add-to-list 'load-path user-emacs-directory)


;; Global editor changes (some are defaults in later versions) 
;;
(setq inhibit-startup-screen 1)
(column-number-mode t)


;; CC-mode mode customizations
;;
;; define default styles
(setq c-default-style '((c-mode . "k&r")
			(java-mode . "java")
			(awk-mode . "awk")
			(other . "gnu")))
;; set auto newline and hungry delete
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-toggle-auto-hungry-state 1)
	    (setq indent-tabs-mode nil)))
;; alter java hanging braces
(add-hook 'java-mode-hook
	  (lambda ()
	    (add-to-list 'c-hanging-braces-alist '(class-open . (after)))
	    (add-to-list 'c-hanging-braces-alist '(inline-open . (after)))))


;; nXML mode customizations
;;

;; override xmltok.el to add erb patch
(eval-after-load "nxml-mode" 
                 '(load (expand-file-name "xmltok.el" user-emacs-directory)))

;; redefine paths for schema files (don't use default installed schemas)
(setq rng-schema-locating-files 
      (list "schemas.xml" 
	    (expand-file-name "schema/schemas.xml" user-emacs-directory)))
(setq rng-schema-locating-file-schema-file 
      (expand-file-name "schema/locate.rnc" user-emacs-directory))

;; add file extensions to match for nXML mode 
(add-to-list 'auto-mode-alist '("\\.xml\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.x?html\\'" . nxml-mode))

;; modify coding for x?html files
(modify-coding-system-alist 'file "\\.x?html\\'" 'utf-8-with-signature)


;; package install 
;;
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-hook 'after-init-hook
	  (lambda ()
	    (load (expand-file-name "packages.el" user-emacs-directory))))


;; Local Changes (not stored in version control)
;;

;; customizations interface
(setq custom-file (expand-file-name "emacs-custom.el" user-emacs-directory))
(load custom-file)

;; other local
(load (expand-file-name "emacs-local.el" user-emacs-directory))
