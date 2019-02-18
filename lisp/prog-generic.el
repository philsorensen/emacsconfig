;;; prog-generic.el --- Set defaults for most programming modes

;; hook for all programming modes
(defun pas-prog-mode-hook ()
  ;; use spaces and end with newline
  (setq indent-tabs-mode nil
	require-final-newline t)
  ;; setup auto-fill and spell-check for comments (except web-mode)
  (unless (equal major-mode "web-mode")
    (setq-local comment-auto-fill-only-comments t)
    (auto-fill-mode)
    (flyspell-prog-mode)))

(add-hook 'prog-mode-hook 'pas-prog-mode-hook)


(provide 'prog-generic)
