;; Install straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

;; load files from the lisp directory
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Packages
(require 'init-dashboard)
(require 'init-doom-modeline)
(require 'init-doom-themes)
(require 'init-evil)
(require 'init-nix)
(require 'init-treemacs)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; General Config ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
