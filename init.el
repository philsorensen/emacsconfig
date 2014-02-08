;;; init.el --- base init file for Emacs

;; This file is in the .emacs.d directory where it is under git.  You
;; need make sure that there is either no ~/.emacs file or the this file
;; is linked to ~/.emacs.
;;
;; The current initialization is for Emacs 24.3.

;;;; Throw error if not right version 

(unless (>= emacs-major-version 24)
  (unless (or (> emacs-major-version 24) (>= emacs-minor-version 3))
    (setq inhibit-startup-screen 1)
    (error "The init.el file only works for version 24.3 or later")))



;;;; basic setup 

;; Turn off interface elements
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; no startup screen
(setq inhibit-startup-screen 1)

;; Customizations in separate files
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; initialize packages.el
(require 'package)

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (unless (package-installed-p package min-version)
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(add-to-list 'package-archives 
	     '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)

;; Define the after macro
(defmacro after (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,feature
     '(progn ,@body)))



;;;; load modular init pieces

;; Add ~/.emacs.d/init to search path
(add-to-list 'load-path (expand-file-name "init" user-emacs-directory))


(require 'defaults)
(require 'appearance)

;; global modes/loads 
(require 'init-speedbar)
(require 'autocomplete)

(require 'programming)
(require 'webmode)

(require 'old)


;;;; Local Customization (not stored in version control)

(let ((local-file (expand-file-name "local.el" user-emacs-directory)))
  (when (not (file-exists-p local-file))
    (shell-command (concat "touch " local-file)))
  (load local-file))
