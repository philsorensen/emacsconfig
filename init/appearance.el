;;; appearance.el --- Set default appearance

;; Always show both line and column numbers 
(column-number-mode t)
(line-number-mode t)

;; Set frame parameters for non-console windows
(when window-system
  (menu-bar-mode 1)

  (setq font-use-system-font t)

  (add-to-list 'default-frame-alist '(width . 80))
  (add-to-list 'default-frame-alist '(height . 40)))

(provide 'appearance)
