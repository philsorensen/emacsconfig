;;; old.el --- customizations from previous init.el 


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

(provide 'old)
