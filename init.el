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
(setq load-path (append load-path user-emacs-directory))


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


;; nXML mode customizations
;;
;; redefine paths for schema files (don't use default installed schemas)
(setq rng-schema-locating-files 
      (list "schemas.xml" 
	    (expand-file-name "schema/schemas.xml" user-emacs-directory)))
(setq rng-schema-locating-file-schema-file 
      (expand-file-name "schema/locate.rnc" user-emacs-directory))

;; add file extensions to match for nXML mode 
(setq auto-mode-alist 
      (cons '("\\.\\(xml\\|x?html\\)\\'" . nxml-mode) auto-mode-alist))

 
;; Local Changes (not stored in version control)
;;

;; customizations interface
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

;; other local
(load "~/.emacs.d/emacs-local.el")
