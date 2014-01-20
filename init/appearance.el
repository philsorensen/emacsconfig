;;; appearance.el --- Set default appearance

;; Always show both line and column numbers 
(column-number-mode t)
(line-number-mode t)

;; Set frame parameters for non-console windows
(when window-system
  ; enable menu
  (menu-bar-mode 1)

  ; turn on linum mode
  (setq linum-format "%4d")
  (global-linum-mode 1)

  ; set font to system default
  (setq font-use-system-font t)

  ; set frame size
  (add-to-list 'default-frame-alist '(width . 85))
  (add-to-list 'default-frame-alist '(height . 40)))


(provide 'appearance)
