;;; init-speedbar.el --- settings for speedbar

;; speedbar in the frame
(require-package 'sr-speedbar)
(require 'sr-speedbar)

;; adjust speedbar parameters
(setq sr-speedbar-right-side nil)
(setq speedbar-use-images nil)

;; key binding
(global-set-key (kbd "C-c s") 'sr-speedbar-toggle)


;; on window systems adjust frame width 
(when window-system
  (setq sr-speedbar-width 30)

  (defadvice sr-speedbar-open (before pas-sr-speedbar-open activate)
    (set-frame-parameter nil 'width 
			 (+ (frame-parameter nil 'width) sr-speedbar-width)))

  (defadvice sr-speedbar-close (after pas-sr-speedbar-close activate)
    (set-frame-parameter nil 'width
			 (- (frame-parameter nil 'width) sr-speedbar-width))))

(provide 'init-speedbar)
