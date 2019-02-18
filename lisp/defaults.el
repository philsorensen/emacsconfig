;;; defaults.el --- Set non-appearence defaults

;; identity
(setq user-full-name "Phillip Sorensen")
(setq user-main-address "phil.a.sorensen@gmail.com")

;; set prefered coding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)

;; set fill parameters
(setq-default fill-column 80)

;; setup spell checker program and arguments (prefer prefer aspell)
(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell"
        ispell-extra-args (list "--sug-mode=ultra" "--lang=en_US")))
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell"
        ispell-local-dictionary "en_US")))

(defun ispell-enable-camalcase ()
    (if (string-match "aspell$" ispell-program-name)
        (setq-local ispell-extra-args (append ispell-extra-args
                                              '("--run-together")))))


(provide 'defaults)
