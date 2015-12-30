;;; webmode.el --- setup web-mode.el

;; HTML/Templates/CSS/Javascript setups

(require-package 'web-mode)
(require-package 'emmet-mode)
(require-package 'scss-mode)


(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(setq web-mode-engines-alist
      '(("django" . "\\.html\\'")))


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
            (setq-local fill-column 80)
            (auto-fill-mode 1)
            (flyspell-mode 1)
            (emmet-mode 1)
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-enable-auto-closing t)
            (setq web-mode-enable-auto-pairing t)))

(add-hook 'emmet-mode-hook
          (lambda()
            (setq emmet-preview-default nil)
            (setq emmet-indentation 2)))

(add-hook 'sccs-mode-hook
          (lambda()
            ;; TODO: flymake setup (node-sass)
            (add-to-list 'ac-source 'ac-source-css-property)))
(add-to-list 'ac-modes 'scss-mode)


(provide 'webmode)
