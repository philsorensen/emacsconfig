;;; defaults.el --- Set non-appearence defaults

;; set prefered coding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)

;; setup spell checker (prefer hunspell)
(if (file-exists-p "/usr/bin/hunspell")
    (setq ispell-program-name "hunspell"))


(provide 'defaults)
