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
(display-time-mode 1)
;; (global-hl-line-mode 1)
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

;; ** global key mapping
;; *** remove stuff
(global-unset-key (kbd "C-z")) 		;remove suspend frame
(global-set-key (kbd "C-c t") 'rename-buffer)
(global-set-key (kbd "<f5>") 'revert-buffer)

(require 'kafkabro/org)
(require 'kafkabro/emacs-lisp)

;; remove tool-bar
(require 'menu-bar)
(menu-bar-showhide-tool-bar-menu-customize-disable)

;; - smex -
(use-package smex :ensure t)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; * helm modes begin
(use-package helm :ensure t)
(global-set-key (kbd "M-s o") 'helm-occur) ;; remap occur to helm-occur
(global-set-key (kbd "C-h a") 'helm-apropos) ;; remap apropos to helm-apropos
(global-set-key (kbd "C-M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
;; ** helm desc key
(use-package helm-descbinds :ensure t)
(helm-descbinds-mode t)
;; ** helm-ag
(use-package helm-ag :ensure t)
;; * helm end


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
(global-set-key (kbd "<C-M-tab>") 'buf-move-right)
(global-set-key (kbd "<C-M-S-iso-lefttab>") 'buf-move-left)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; - which-key
(use-package which-key :ensure t)
(which-key-mode 1)

;; * nispio section begin
(require 'nispio/helm-silver)
(require 'nispio/helm-extra)
(require 'nispio/mc-extra)
(nispio/mc-setup-mark-lines)
(nispio/setup-helm-apropos)
(global-set-key (kbd "C-h A") 'nispio/helm-customize-group)
(global-set-key (kbd "C-h M-a") 'nispio/helm-customize-option)
;; * nispio section end

;; - hg support (monky)
(use-package monky :ensure t)

;; * dumb-jump
(use-package dumb-jump :ensure t)
(dumb-jump-mode 1)

;; discover-my-major
(use-package discover-my-major :ensure t)
;; discover
(use-package discover :ensure t)

;; * shell begin
(defun wgs85/shell-mode-hook ()
  (local-unset-key (kbd "M-p")) 	; remove comint-previous-input from local map
  (local-set-key (kbd "M-p") 'comint-previous-matching-input-from-input)
  )
(add-hook 'shell-mode-hook 'wgs85/shell-mode-hook)
;; * shell end

;; * magit
(use-package magit :ensure t)
;; * geeknote begin
(use-package geeknote :ensure t)
;; * geeknote end


;; - spotify
(use-package spotify :ensure t)
(spotify-enable-song-notifications)

;; - helm-spotify
(use-package helm-spotify :ensure t)

;; * ace-link begin
(use-package ace-link :ensure t)
(ace-link-setup-default "f")
;; * ace-link end

;; gnuplot begin
(use-package gnuplot :ensure t)
(use-package gnuplot-mode :ensure t)

;; zygosphere
(use-package zygospore :ensure t)
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)

;; undo tree
(use-package undo-tree :ensure t)
(undo-tree-mode 1)

;; machine-specific config
(defun wgs85/fathertron-config ()
  (set-face-attribute 'default nil :height 90)
  )

(when (or (string= system-name "fatherTron-Manjaro")
	  (string= system-name "fatherTron-Manjaro.Home"))
  (wgs85/fathertron-config))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(buffer-move-behavior (quote move))
 '(dired-hide-details-hide-information-lines t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(helm-split-window-default-side (quote right))
 '(magit-log-arguments
   (quote
    ("--graph" "--color" "--decorate" "--patch" "-n256")))
 '(menu-bar-mode nil)
 '(org-M-RET-may-split-line nil)
 '(org-agenda-dim-blocked-tasks nil)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-skip-timestamp-if-done t)
 '(org-agenda-span (quote week))
 '(org-agenda-start-on-weekday nil)
 '(org-clock-clocked-in-display (quote both))
 '(org-clock-in-switch-to-state "DOING")
 '(org-clock-into-drawer "LOGBOOK")
 '(org-clock-mode-line-total (quote current))
 '(org-clock-out-switch-to-state "PAUSE")
 '(org-completion-use-ido t)
 '(org-disputed-keys
   (quote
    (([(shift up)]
      .
      [(meta shift p)])
     ([(shift down)]
      .
      [(meta shift n)])
     ([(shift left)]
      .
      [(meta \[)])
     ([(shift right)]
      .
      [(meta \])])
     ([(control shift right)]
      .
      [(meta control \[)])
     ([(control shift left)]
      .
      [(meta control \])]))))
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-enforce-todo-dependencies t)
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(org-insert-heading-respect-content t)
 '(org-log-into-drawer t)
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 3))))
 '(org-replace-disputed-keys t)
 '(org-return-follows-link t)
 '(org-special-ctrl-a/e t)
 '(org-startup-align-all-tables t)
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t!)" "STARTED(s!)" "BLOCKED(b@/!)" "DOING(d)" "PAUSE(p)" "|" "DONE(o!)" "CANCEL(x@)"))))
 '(org-treat-insert-todo-heading-as-state-change t)
 '(revert-without-query (quote (".*")))
 '(shell-file-name "/usr/bin/tcsh")
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
