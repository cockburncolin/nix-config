;; treemacs configuration

(use-package treemacs
  :straight t
  :config
  (use-package treemacs-evil
    :after (treemacs evil)
    :straight t))

(provide 'init-treemacs)
