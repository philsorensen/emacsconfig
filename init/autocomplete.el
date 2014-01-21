;;; autocomplete.el --- setup auto-complete package

(require-package 'auto-complete)

(require 'auto-complete-config)

;; create symbolic link from javascript-mode to js-mode
(let* ((autodir (file-name-directory (symbol-file 'auto-complete)))
       (dictdir (expand-file-name "dict" autodir)))
  (unless (file-exists-p (expand-file-name "js-mode" dictdir))
    (cd-absolute dictdir)
    (make-symbolic-link "javascript-mode" "js-mode")))


;; defaults for now
(ac-config-default)

;; add overrides
(after 'flyspell
  (ac-flyspell-workaround))

(after 'linum
  (ac-linum-workaround))


(provide 'autocomplete)
