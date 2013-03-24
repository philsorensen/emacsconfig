;;
;; Setup for packages installed with package.el
;;

;; setup melpa
(unless (package-installed-p 'melpa)
  (switch-to-buffer
   (url-retrieve-synchronously
    "https://raw.github.com/milkypostman/melpa/master/melpa.el"))
  (package-install-from-buffer  (package-buffer-info) 'single))

(require 'melpa)


;; install wanted packages
(setq pkgs-wanted
      '(auto-complete))

(dolist (pkg pkgs-wanted)
  (unless (package-installed-p pkg)
    (package-refresh-contents)
    (package-install pkg)))


;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
