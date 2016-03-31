;;
(server-start)
;;
(load-theme (quote deeper-blue))
;; -- Minor Modes Begin --
(electric-pair-mode 1)
(show-paren-mode 1)
(column-number-mode 1)
(ido-mode 1)
(global-linum-mode 1)
;; -- Minor Modes End --
;;
(setq mouse-autoselect-window t)
;; -- window management related -- 
(windmove-default-keybindings)
;; ctrl-tab support
(global-set-key (kbd "<C-tab>") 'next-multiframe-window)
(global-set-key (kbd "<C-iso-lefttab>") 'previous-multiframe-window)
;; -- window management end --


;; -- Paths/Packages Etc
;; packages
(setq package-archives '())
;; (add-to-list 'package-archives '("local-misc" . "~/.emacs.d/local-elpa-misc/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/")) 
(add-to-list 'package-archives '("melpa" . "http://melpa.org/#/"))
;; site-lisp
(setq site-lisp "~/.emacs.d/site-lisp")
(add-to-list 'load-path site-lisp)
;; initialize packages and grab use-package
(package-initialize)  ;; add elpa to the load path?
(require 'use-package) ;; note: if fail, install use-package manually
;; -- Path/Packages End

;; remove tool-bar
(require 'menu-bar)
(menu-bar-showhide-tool-bar-menu-customize-disable)

;; - org-mode -
(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-agenda-files '("~/Dropbox/org"))
(defun wgs85/org-mode-hook ()
  (local-set-key (kbd "<C-tab>") 'next-multiframe-window)
  )
(add-hook 'org-mode-hook 'wgs85/org-mode-hook)

;; - smex -
(use-package smex :ensure t)
(global-set-key (kbd "M-x") 'smex)

;; - helm -
(use-package helm :ensure t)
(global-set-key (kbd "M-s o") 'helm-occur) ;; remap occur to helm-occur
(global-set-key (kbd "C-h a") 'helm-apropos) ;; remap apropos to helm-apropos

;; - multiple cursors -
;; (use-package multiple-cursors :ensure t)

;; - avy -
(use-package avy :ensure t)
(global-set-key (kbd "C-;") 'avy-goto-word-or-subword-1)
