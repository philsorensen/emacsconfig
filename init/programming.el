;;; programming.el --- setup programming modes

;;;; setup of various language related packages

;; yasnippet
(require-package 'yasnippet)
(require 'yasnippet)

(yas-global-mode 1)    ; turn on global to initialize
(yas-global-mode 0)    ; turn off globally 


;;;; hooks and setup for languages

;; setup for all programming modes
(add-hook 'prog-mode-hook
          (lambda ()
            ;; only use spaces and end with newline
            (setq indent-tabs-mode nil)
            (setq require-final-newline t)

            ;; auto-fill and spell-check comments
            (setq-local fill-column 80)
            (setq-local comment-auto-fill-only-comments t)
            (auto-fill-mode)
            (flyspell-prog-mode)))


(provide 'programming)
