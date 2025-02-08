;; doom-themes configuration
(use-package doom-themes
	     :straight t
	     :config
	     (setq doom-themes-enable-bold t
		   doom-themes-enable-italic t)
	     (load-theme 'doom-one t))

(provide 'init-doom-themes)
