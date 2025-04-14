;;;; Package Management
;; Install Straight
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

;; Install use-package
(straight-use-package 'use-package)

;; Set use-package to use straight by default
(setq straight-use-package-by-default t)

;;;; Evil Mode
(use-package evil
  :init
  (setq evil-want-keybinding nil)
    :config
        (evil-mode 1)
        (use-package evil-collection
          :config
          (evil-collection-init)))

;;;; General Key Bindings
;; Install which key
(use-package which-key
  :init
    (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
          which-key-sort-order #'which-key-key-order-alpha
          which-key-sort-uppercase-first nil
          which-key-add-column-padding 1
          which-key-max-display-columns nil
          which-key-min-display-lines 6
          which-key-side-window-slot -10
          which-key-side-window-max-height 0.25
          which-key-idle-delay 0.8
          which-key-max-description-length 25
          which-key-allow-imprecise-window-fit t
          which-key-separator " → " ))

;; General.el keybinds
(use-package general
  :config
  (general-evil-setup t)
  ;; set up 'SPC' as the global leader key
  (general-create-definer leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  ;; Misc keybinds
  (leader-keys
    "."       '(find-file :wk "Find file")
    ;; One line script to edit the Emacs config file
    "f c"     '((lambda () (interactive) (find-file "~/.config/emacs/init.el")) :wk "Edit emacs config")
    "TAB TAB" '(comment-line :wk "Comment lines"))

  ;; Buffer related keybinds
  (leader-keys
    "b"   '(:ignore t :wk "Buffer")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b i" '(ibuffer :wk "Ibuffer")
    "b k" '(kill-this-buffer :wk "Kill this buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer"))

  ;; Evaulate LISP keybinds
  (leader-keys
    "e"   '(:ignore t :wk "Evaluate")
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region"))

   ;; Help keybinds
   (leader-keys
    "h"     '(:ignore t :wk "Help")
    "h f"   '(describe-function :wk "Describe function")
    "h v"   '(describe-variable :wk "Describe variable"))

   ;; Toggle keybinds
   (leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t t" '(visual-line-mode :wk "Toggle truncated lines"))

   ;; Org specific keybinds
   (leader-keys
     "o" '(:ignore t :wk "Org-Mode")
     "o e" '(org-edit-special :wk "Edit source block")
     "o E" '(org-edit-src-exit :wk "Exit source block"))
)
;;;; Major/Minor Mode Configs & Code Formatters
(use-package json-mode
  :mode "\\.json\\'")

(use-package markdown-mode
  :mode "\\.md\\'")

(use-package nix-mode
  :mode "\\.nix\\'"
  :config
  (use-package nixfmt
    :config
    (add-hook 'nix-mode-hook 'nixfmt-on-save-mode)))

(use-package elisp-autofmt
  :config
  (add-hook 'elisp-mode-hook 'elisp-autofmt-mode))

(use-package flycheck
    :init
    (global-flycheck-mode))

;;;; Dashboard Setup
(use-package dashboard
  :init
  (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner "~/.config/emacs/osaka.png")
  (setq dashboard-item-shortcuts '((recents   . "r")
                                   (bookmarks . "b")
                                   (projects  . "p")
                                   (agenda    . "a")
                                   (registers . "e")))
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons))

;;;; UI settings
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
;; enable line numbers in programming modes only
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Modeline package
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-buffer-file-name-style 'truncate-nil))

;;;; Editor behaviour
(auto-save-mode nil)
(setq tab-width 4)

;; Handler of paired delimiters ie. parenthesis, HTML tags, etc.
(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t))

;; Makes find file easier to use
(use-package vertico
  :init
  (vertico-mode))

;; Snippet system
(use-package yasnippet
  :config
  (yas-global-mode 1))

;; Enables visual indentation markers, options for format are fill, column, character and bitmap
(use-package highlight-indent-guides
:init
(setq highlight-indent-guides-method 'bitmap)
:config
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(use-package golden-ratio
  :config
  (setq golden-ratio-auto-scale t)
  (golden-ratio-mode 1))

(use-package sudo-edit
  :config
    (leader-keys
      "f u" '(sudo-edit-find-file :wk "Sudo find file")
      "f U" '(sudo-edit :wk "Sudo edit file")))

;;;; Org-mode Config
(setq org-src-tab-acts-natively t)
;; org-tempo is a builtin package that doesn't need to be installed, just activated
(require 'org-tempo)

;;;; Magit
(use-package magit
  :config
  (leader-keys
    "g"  '(magit :wk "Launch Magit")))

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

(provide 'init)
;;; init.el ends here
