;;; programming.el --- setup programming modes

;; This file contains setup for major modes derived from prog-mode.  The one
;; exception is web-mode which has been broken out into it's own file, and some
;; options are not applied.


;;;; setup of various language related packages

;; yasnippet
(require-package 'yasnippet)
(require 'yasnippet)

(yas-global-mode 1)    ; turn on global to initialize
(yas-global-mode 0)    ; turn off globally 

;; lintnode for javascript
(let ((lintnode-dir (expand-file-name "node_modules/lintnode"
                                      user-emacs-directory)))
  (when (not (file-directory-p lintnode-dir))
    (cd-absolute user-emacs-directory)
    (shell-command "npm install lintnode"))
  (add-to-list 'load-path lintnode-dir))

(after 'flymake-jslint
  (setq lintnode-autostart t)
  (setq lintnode-location (expand-file-name "node_modules/lintnode" 
                                            user-emacs-directory)))


;;;; hooks and setup for languages

;; setup for all programming modes
(add-hook 'prog-mode-hook
          (lambda ()
            ;; only use spaces and end with newline
            (setq indent-tabs-mode nil)
            (setq require-final-newline t)

            ;; auto-fill and spell-check comments (ignore for web-mode)
            (unless (equal major-mode "web-mode")
              (setq-local fill-column 80)
              (setq-local comment-auto-fill-only-comments t)
              (auto-fill-mode)
              (flyspell-prog-mode))))


;; javascript - js-mode
(require-package 'flymake-cursor)

(add-hook 'js-mode-hook
          (lambda()
            ;; flymake settings
            (require 'flymake-cursor)
            (require 'flymake-jslint)
            (lintnode-hook)

            ;; other minor modes
            (yas-minor-mode)))


(provide 'programming)
