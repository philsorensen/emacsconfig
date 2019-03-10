;;; completion.el --- Setup completion modes


;; company - auto-completion backend
(use-package company
  :ensure t
  :hook (after-init . global-company-mode))


(provide 'completion)
