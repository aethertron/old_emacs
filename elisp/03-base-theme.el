(set-face-attribute 'default nil :height 120)

(use-package solarized-theme :ensure t
  :demand
  :config
  (load-theme 'solarized-dark t))

(use-package smart-mode-line-powerline-theme :ensure t)
(setq sml/theme 'dark)
(sml/setup)

(provide '03-base-theme)
