;; dashboard configuration

(use-package dashboard
  :straight t
  :config
  (use-package nerd-icons
    :straight t)
  (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  (setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
  (setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-banner-logo-title "Emacs? More like PEEMACS!")
  (setq dashboard-startup-banner "~/.config/emacs/bribing-scene-cleaned.png")
  (setq dashboard-startupify-list '(dashboard-insert-banner
                                  dashboard-insert-newline
                                  dashboard-insert-banner-title
                                  dashboard-insert-newline
                                  dashboard-insert-navigator
                                  dashboard-insert-newline
                                  dashboard-insert-items
                                  dashboard-insert-newline
                                  dashboard-insert-init-info))
  (dashboard-setup-startup-hook))

(provide 'init-dashboard)
