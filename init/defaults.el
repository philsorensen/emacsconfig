;;; defaults.el --- Set non-appearence defaults

;; setup spell checker (prefer hunspell)
(if (file-exists-p "/usr/bin/hunspell")
    (setq ispell-program-name "hunspell"))


(provide 'defaults)
