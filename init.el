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
(global-hl-line-mode 1)
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
(require 'package)
(setq package-archives '())
;; (add-to-list 'package-archives '("local-misc" . "~/.emacs.d/local-elpa-misc/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
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

;; * org-mode begin
(require 'org)
(require 'org-habit)
;; key config
;; (add-to-list 'org-modules 'org-habit)
;; ** agenda config
(setq org-agenda-files '("~/org" "~/org.spideroak"))
;; ** babel config
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . t)
   (js . t)
   (sh . t)
   (org . t)
   ;; *** diagraming langs
   (ditaa . t)
   (plantuml . t)))

;; ** org-mode hook
(defun wgs85/org-mode-hook ()
  (local-set-key (kbd "<C-tab>") 'next-multiframe-window)
  (org-indent-mode)
  (local-set-key (kbd "C-c a") 'org-agenda)
  )
(add-hook 'org-mode-hook 'wgs85/org-mode-hook)
;; * org-mode end 

;; - smex -
(use-package smex :ensure t)
(global-set-key (kbd "M-x") 'smex)

;; - helm -
(use-package helm :ensure t)
(global-set-key (kbd "M-s o") 'helm-occur) ;; remap occur to helm-occur
(global-set-key (kbd "C-h a") 'helm-apropos) ;; remap apropos to helm-apropos
(global-set-key (kbd "M-X") 'helm-M-x)

;; - avy -
(use-package avy :ensure t)
(global-set-key (kbd "C-;") 'avy-goto-word-or-subword-1)

;; * multiple cursors begin
(use-package multiple-cursors :ensure t)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "M-s M-s") 'mc--mark-symbol-at-point)
(global-set-key (kbd "C-c C->") 'mc/mark-more-like-this-extended)

;; * multiple cursors end

;; - buffer-move -
(use-package buffer-move :ensure t)


;; - which-key
(use-package which-key :ensure t)
(which-key-mode 1)


;; - spotify
(use-package spotify :ensure t)
(spotify-enable-song-notifications)

;; - helm-spotify
(use-package helm-spotify :ensure t)

;; - hg support (monky)
(use-package monky :ensure t)


(defun wgs85/fathertron-config ()
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:inherit nil :stipple nil :background "#181a26" :foreground "gray80"
			   :inverse-video nil :box nil :strike-through nil :overline nil
			   :underline nil :slant normal :weight normal :height 90
			   :width normal :foundry "PfEd" :family "DejaVu Sans Mono")))))
  )

(when (or (string= system-name "fatherTron-Manjaro")
	  (string= system-name "fatherTron-Manjaro.Home"))
  (wgs85/fathertron-config))
