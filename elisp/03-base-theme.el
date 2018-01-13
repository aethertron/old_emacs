(set-face-attribute 'default nil :height 120)

(use-package solarized-theme :ensure t
  :demand
  :config
  (load-theme 'solarized-dark t))

;; Was run at some point:
;; (use-package anti-zenburn-theme :ensure t :demand)
;; (use-package cyberpunk-theme :ensure t :demand)
;; (use-package darktooth-theme :ensure t :demand)
;; (use-package monokai-theme :ensure t :demand)
;; (use-package noctilux-theme :ensure t :demand)
;; (use-package solarized-theme :ensure t :demand)
;; (use-package spacemacs-theme :ensure t :demand)
;; (use-package zenburn-theme :ensure t :demand)

(provide '03-base-theme)
