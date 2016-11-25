;;; init.el --- base init file for Emacs

;; This file is in the .emacs.d directory where it is under git.  You
;; need make sure that there is either no ~/.emacs file or the this file
;; is linked to ~/.emacs.
;;
;; The current initialization is for Emacs 25.1.
;;

;;;; Throw error if not right version 

(unless (>= emacs-major-version 25)
  (unless (or (> emacs-major-version 25) (>= emacs-minor-version 1))
    (setq inhibit-startup-screen t)
    (error "The init.el works for version 25.1 or later")))



;;;; Basic Setup

;; Turn off interface elements
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No startup screen
(setq inhibit-startup-screen t)


;; Customizations in separate files
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Local settings (not stored in version control)
(let ((local-file (expand-file-name "local.el" user-emacs-directory)))
  (when (not (file-exists-p local-file))
    (shell-command (concat "touch " local-file)))
  (load local-file))



;;;; Initialize package.el and use-package.el

;;; Initial package.el setup

(require 'package)

(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)


;;; Setup use-package

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Load needed packages
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

;; Configure use-package
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(setq use-package-always-defer t)
(setq use-package-always-ensure t)
(setq use-package-always-pin "melpa-stable")



;;;; load modular init pieces

;; Add ~/.emacs.d/init to search path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))


(require 'defaults)
(require 'appearance)

;; global modes/loads 
;(require 'init-speedbar)
;(require 'autocomplete)

;(require 'programming)
;(require 'webmode)

;(require 'other)
;(require 'old)
