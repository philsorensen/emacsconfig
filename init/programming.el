;; programming.el --- setup programming modes

;; setup for all programming modes
(add-hook 'prog-mode-hook
          (lambda ()
            ; only use spaces and end with newline
            (setq indent-tabs-mode nil)
            (setq require-final-newline t)

            ; auto-fill and spell-check comments
            (setq-local fill-column 80)
            (setq-local comment-auto-fill-only-comments t)
            (auto-fill-mode)
            (flyspell-prog-mode)))


(provide 'programming)
