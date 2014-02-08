;;; webmode.el --- setup web-mode.el

;; HTML/Templates/CSS/Javascript setups

(require-package 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(defun web-mode-flyspefll-verify ()
  (let ((f (get-text-property (- (point) 1) 'face)))
    (not (memq f '(web-mode-html-attr-value-face
                   web-mode-html-tag-face
                   web-mode-html-attr-name-face
                   web-mode-doctype-face
                   web-mode-keyword-face
                   web-mode-function-name-face
                   web-mode-variable-name-face
                   web-mode-css-property-name-face
                   web-mode-css-selector-face
                   web-mode-css-color-face
                   web-mode-type-face
                   web-mode-block-control-face
                   )
               ))))
(put 'web-mode 'flyspell-mode-predicate 'web-mode-flyspefll-verify)

(add-hook 'web-mode-hook
          (lambda()
            (setq-local fill-column 72)
            (auto-fill-mode 1)
            (flyspell-mode 1)))


(provide 'webmode)
