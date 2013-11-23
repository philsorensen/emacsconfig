;;
;; init.el file
;;
;; This file is in the .emacs.d directory where it is under git.  You
;; need make sure that there is either no ~/.emacs file or the this file
;; is linked to ~/.emacs.
;;
;; Current file is designed for versions 24.1 or later.  Variables
;; and functions should be checked for new defaults, additions,
;; etc. when old versions are dropped or added.
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
			(c++-mode . "stroustrup")
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
