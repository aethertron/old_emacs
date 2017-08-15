;; Require header
(use-package bind-key)



;; Builtin Packages

(use-package autorevert
  :config
  (global-auto-revert-mode)
  (setq global-auto-revert-non-file-buffers "t"))

(use-package hideshow
  :config
  (add-hook 'prog-mode-hook 'hs-minor-mode))

(use-package ibuffer
  :config
  (bind-keys ("C-x C-b" . ibuffer)))

(use-package vc
  :config
  (require 'dash)
  (require 'vc-dir)

  (setq vc-log-show-limit 32)

  (defun bgs-vc-copy-marked-as-kill ()
    (interactive)
    (let ((string (s-join " " (vc-dir-marked-files))))
      (kill-new string)
      (message (format "Copied to kill ring: %s" string))))

  (defun bgs-vc-dir-at-root ()
    (interactive)
    (vc-dir (vc-root-dir)))

  (defun bgs-vc-dir-at-cwd ()
    (interactive)
    (vc-dir default-directory))

  (bind-key "w" 'bgs-vc-copy-marked-as-kill vc-dir-mode-map)

  (bind-key "C-x v" 'vc-prefix-map)

  (bind-keys :map vc-prefix-map
	     ("D" . bgs-vc-dir-at-root)
	     ("d" . bgs-vc-dir-at-cwd)))


;; Additional Packages

(use-package ag)

(use-package avy
  :bind
  ("C-;"     . avy-goto-word-1))

(use-package buffer-move
  :bind
  ("<C-S-up>"    . buf-move-up)
  ("<C-S-down>"  . buf-move-down)
  ("<C-S-left>"  . buf-move-left)
  ("<C-S-right>" . buf-move-right)
  :config
  ;; buffer moves instead of swapping the windows
  ;;   buffers are thus like pieces of paper on a desktop
  (setq buffer-move-behavior 'move))

(use-package company
  :config
  (defun bgs-print-backend ()
    (interactive)
    (message (format "Active Backend: %s" company-backend)))
  (bind-keys :map company-active-map
	     ("C-n" . company-select-next)
	     ("C-p" . company-select-previous)
	     ("C-b" . bgs-print-backend))
  (global-company-mode))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq-default ediff-highlight-all-diffs 'nil)
  (setq ediff-diff-options "-w"))

(use-package exec-path-from-shell
  :config
  ;; Add GOPATH to shell
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "PYTHONPATH")
    (exec-path-from-shell-initialize)))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package flycheck)

(use-package counsel
  :init
  (counsel-mode)
  (counsel-projectile-on)
  :bind
  ;; ag
  ("M-s l" . counsel-ag)
  ("M-s d" . counsel-dired-jump)
  ("C-h p" . counsel-find-library)
  :config
  (use-package ivy)

  (bind-keys :map counsel-mode-map
	     :prefix-map counsel-prefix-map
	     :prefix "C-c I"
	     ("l" . counsel-ag)
	     ("f" . counsel-locate)
	     ("d" . counsel-dired-jump)
	     ("x" . counsel-linux-app)
	     ("o" . counsel-outline)
	     ("s" . counsel-set-variable))

  (setq counsel-find-file-at-point "t"
	counsel-mode-lighter "")	; needs patch of counsel in order to work
  (when (package-installed-p 'company)
    (define-key global-map [remap completion-at-point] 'counsel-company)))

(use-package counsel-projectile
  :bind
  ;; ("C-x v" . counsel-projectile) ;; deactive for now
  ("C-x c p" . counsel-projectile-ag)
  :config
  (counsel-projectile-on))

(use-package help-fns+
  ;; this adds keybindings to help-map
  )

(use-package ivy
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil)
  (bind-key "C-r" 'counsel-expression-history read-expression-map)
  (bind-keys ("M-s s" . isearch-forward))
  :bind
  ("C-s" . swiper)
  ("C-x C-r" . ivy-resume))

(use-package ivy-hydra)

(use-package hlinum
  :config
  (hlinum-activate))

(use-package man
  :config
  (setq Man-width 90))

(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode nil))

(use-package magit
  :config

  (setq magit-completing-read-function 'ivy-completing-read)

  :bind
  ;; Magic
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))

(use-package magit-popup)

(use-package move-text
  :bind
  ("M-n"      . move-text-down)
  ("M-p"      . move-text-up)
  ("<M-down>" . move-text-down)
  ("<M-up>"   . move-text-up))

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C->" . mc/mark-all-like-this)
  ("C-c C-<" . mc/mark-more-like-this-extended)
  :bind
  (:map mc/keymap
	("C-c C-n" . mc/insert-numbers)
	("C-'" . mc-hide-unmatched-lines-mode)))

(use-package neotree
  :config
  (setq neo-theme 'arrow
        neotree-smart-optn t
        neo-window-fixed-size nil)
  ;; Disable linum for neotree
  (add-hook 'neo-after-create-hook 'disable-neotree-hook))

(use-package page-break-lines
  :config
  (global-page-break-lines-mode))

(use-package projectile
  :config
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" temp-dir)
	projectile-cache-file
        (expand-file-name "projectile-cache" temp-dir))
  (setq projectile-completion-system 'ivy)

  (projectile-global-mode))

(use-package recentf
  :config
  (setq recentf-save-file (recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package smex)

(use-package string-inflection)

(use-package undo-tree
  :config
  ;; Remember undo history
  (setq
   undo-tree-auto-save-history nil
   undo-tree-history-directory-alist `(("." . ,(concat temp-dir "/undo/"))))
  (global-undo-tree-mode 1))

(use-package which-key
  :config
  (which-key-mode))

(use-package windmove
  :bind
  ("<C-up>" . windmove-up)
  ("<C-down>" . windmove-down)
  ("<C-left>" . windmove-left)
  ("<C-right>" . windmove-right))

(use-package wgrep)

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package zygospore
  :bind
  ("C-x 1" . zygospore-toggle-delete-other-windows))


(provide '04-base-extensions)
