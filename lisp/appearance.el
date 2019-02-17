;;; appearance.el --- Set default appearance

;; Always show both line and column numbers 
(column-number-mode t)
(line-number-mode t)

;; Set frame appearance for non-console windows
(when (eq window-system 'x)
  ;; enable menu
  (menu-bar-mode 1)

  ;; turn on linum mode
  (setq linum-format "%4d")
  (global-linum-mode 1)

  ;; set font to system default
  (setq font-use-system-font t)

  ;; set frame size
  (setq initial-frame-alist
        '((width . 85)
          (height . 40)))

  (setq default-frame-alist
        '((width . 85)
          (height . 40)))

  (set-frame-size nil 85 40))


(provide 'appearance)
