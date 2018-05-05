;; Require header
(use-package bind-key :ensure t)

;;; Additional Packages


(use-package ace-link :ensure t
  :after (org)
  :init
  (ace-link-setup-default "f")
  :bind
  ("C-c f" . ace-link)
  ("M-g l" . ace-link)
  (:map org-agenda-keymap
        ("C-c f" . ace-link))
  (:map org-mode-map
        ("C-c f" . ace-link)))


(use-package ace-window :ensure t
  :bind
  ("C-;" . ace-window)
  ("M-g b" . ace-window)
  :config
  ;; note "aw" = ace-window
  (setq aw-dispatch-always "t"))


(use-package ag :ensure t
  :config
  (add-hook 'ag-mode-hook 'next-error-follow-minor-mode))


(use-package avy :ensure t
  :init
  ;; (defvar nav-prefix-map (make-sparse-keymap))
  :bind
  ("C-'"     . avy-goto-word-1)
  ("M-g r" . avy-goto-line)
  ("M-g w" . avy-goto-word-1))


(use-package buffer-move :ensure t
  :bind
  ("<C-S-up>"    . buf-move-up)
  ("<C-S-down>"  . buf-move-down)
  ("<C-S-left>"  . buf-move-left)
  ("<C-S-right>" . buf-move-right)
  :config
  ;; buffer moves instead of swapping the windows
  ;;   buffers are thus like pieces of paper on a desktop
  (setq buffer-move-behavior 'move))


(use-package company :ensure t
  :init
  (defun bgs-print-backend ()
    (interactive)
    (message (format "Active Backend: %s" company-backend)))
  (global-company-mode)
  (defvar company-prefix-map (make-sparse-keymap))
  :bind
  ("C-M-i" . company-complete)
  ("C-c c" . company-complete)
  ("C-c d" . company-files)
  :bind (:map company-active-map
	     ("C-n" . company-select-next)
	     ("C-p" . company-select-previous)
	     ("C-b" . bgs-print-backend))
  :bind (:prefix-map company-prefix-map
              :prefix "C-c C"
              ("f" . company-files)
              ("c" . company-complete)
              ("d" . company-dabbrev)))


(use-package counsel :ensure t :defer t)

(defun counsel-ag-modified (&optional initial-input initial-directory extra-ag-args ag-prompt)
  "Modified to override counsel-ag's decision to look for .git files, this should be low level in cwd.
   Fixes everything by setting `initial-directory' to `default-directory' whenever prefix arg isn't present"
  (interactive)
  (unless current-prefix-arg
    (unless initial-directory
      (setq initial-directory default-directory)))
  (counsel-ag initial-input initial-directory extra-ag-args ag-prompt))

(use-package counsel :ensure t
  :init
  (defvar counsel-prefix-map (make-sparse-keymap))
  (counsel-mode)
  :bind (:map counsel-mode-map
              ("M-s f" . bgs-counsel-file-jump)
              ("M-s l" . counsel-ag-modified)
              ("M-s d" . counsel-dired-jump)
              ("C-h p" . counsel-find-library))

  :bind
  (:map counsel-mode-map
        :prefix-map counsel-prefix-map
        :prefix "C-c I"
        ("d" . counsel-dired-jump)
        ("f" . bgs-counsel-file-jump)
        ("l" . counsel-ag-modified)
        ("o" . counsel-outline)
        ("p" . counsel-package)
        ("s" . counsel-set-variable)
        ("t" . counsel-load-theme)
        ("u" . counsel-unicode-char)
        ("x" . counsel-linux-app))
  :custom
  (counsel-find-file-at-point t)
  (counsel-yank-pop-preselect-last 0)
  :config
  (use-package ivy :ensure t)
  (defun bgs-counsel-file-jump (&optional initial-input initial-directory)
    "Jump to a file below the current directory.
List all files within the current directory or any of its subdirectories.
INITIAL-INPUT can be given as the initial minibuffer input.
INITIAL-DIRECTORY, if non-nil, is used as the root directory for search."
    (interactive
     (list nil
           (when current-prefix-arg
             (read-directory-name "From directory: "))))
    (counsel-require-program "find")
    (let* ((default-directory (or initial-directory default-directory)))
      (ivy-read "Find file: "
                (split-string
                 (shell-command-to-string "find . -type f -not -path '*\/.git*'")
                 "\n" t)
                :matcher #'counsel--find-file-matcher
                :initial-input initial-input
                :action (lambda (x)
                          (with-ivy-window
                            (find-file (expand-file-name x ivy--directory))))
                :preselect (when counsel-find-file-at-point
                             (require 'ffap)
                             (let ((f (ffap-guesser)))
                               (when f (expand-file-name f))))
                :require-match 'confirm-after-completion
                :history 'file-name-history
                :keymap counsel-find-file-map
                :caller 'counsel-file-jump)))
  (defun print-variable (var)
    (interactive)
    (insert (format "%s" (eval (intern var)))))
  (ivy-add-actions #'counsel-describe-variable '(("p" print-variable "print")))
  (ivy-add-actions #'counsel-find-file '(("v" vlf "open as very large file")))
  (eval-after-load "company"
    '(progn
       (bind-keys :map counsel-mode-map ("C-:" . counsel-company)))))

(bind-keys :map comint-mode-map
           ("M-r" . counsel-shell-history))

(bind-keys :map counsel-imenu-map
           ("C-M-p" . ivy-previous-line)
           ("C-p" . ivy-previous-line-and-call)
           ("C-M-n" . ivy-next-line)
           ("C-n" . ivy-next-line-and-call))

(bind-keys
   ("C-h b" . counsel-descbinds)
   ("C-h f" . counsel-describe-function)
   ("C-h v" . counsel-describe-variable))


(use-package counsel-projectile :ensure t
  :demand
  :bind
  ("C-x c p" . counsel-projectile-ag)
  :bind
  (:map projectile-command-map
        ("s s" . counsel-projectile-ag))
  :config
  (projectile-mode))


(use-package counsel-pydoc :ensure t)



(use-package counsel-world-clock :ensure t
             :bind
             (:map counsel-prefix-map
                   ("w" . counsel-world-clock))
	     :config
	     (setq counsel-world-clock--time-zones
		   (cons "UTC" counsel-world-clock--time-zones)))

(use-package csv-mode :ensure t
  :mode "\\.csv.txt\\'")


(use-package dashboard :ensure t
  :after (org)
  :init
  (setq dashboard-items '((projects . 5)
                          (bookmarks . 5)
                          (recents . 5)
                          (agenda . 5)))
  :config
  (dashboard-setup-startup-hook))


(use-package dumb-jump :ensure t)



(use-package ediff :ensure t
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq-default ediff-highlight-all-diffs 'nil)
  (setq ediff-diff-options "-w")
  :bind
  ("C-c v" . ediff-buffers))


(use-package exec-path-from-shell :ensure t
  :config
  ;; Add GOPATH to shell
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "PYTHONPATH")
    (exec-path-from-shell-initialize)))


(use-package expand-region :ensure t
  :init
  (defvar expand-region-prefix-map (make-sparse-keymap))
  :bind
  ("C-=" . er/expand-region)
  :bind (:prefix-map expand-region-prefix-map
              :prefix "C-c M"
              ("c" . er/contract-region)
              ("o" . er/mark-org-code-block)
              ("p" . er/mark-python-statement)
              ("s" . er/mark-sentence)
              ("t" . er/mark-text-sentence)
              ("u" . er/mark-symbol)))


(use-package flycheck :ensure t)



(use-package help-fns+ :ensure t
  :bind
    ("C-h M" . describe-mode))


(use-package helpful :ensure t
  :bind
   ("C-h c" . helpful-command)
   ("C-h d" . helpful-symbol)
   ("C-h k" . helpful-key)
   ("C-h m" . helpful-macro)
   ("C-h ." . helpful-at-point))

(if (package-installed-p 'counsel)
    (setq counsel-describe-function-function #'helpful-function
          counsel-describe-variable-function #'helpful-variable)
  (bind-keys
            ("C-h f" . helpful-function)
            ("C-h v" . helpful-variable)))


(use-package highlight :ensure t
  :demand
  :bind
  ("C-x C-y" . hlt-highlight))


(use-package hlinum :ensure t
  :config
  (hlinum-activate))


(use-package hydra :ensure t :defer t)

(defun hydra-move-splitter-left (arg)
  "Move window splitter left."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (shrink-window-horizontally arg)
    (enlarge-window-horizontally arg)))

(defun hydra-move-splitter-right (arg)
  "Move window splitter right."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (enlarge-window-horizontally arg)
    (shrink-window-horizontally arg)))

(defun hydra-move-splitter-up (arg)
  "Move window splitter up."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (enlarge-window arg)
    (shrink-window arg)))

(defun hydra-move-splitter-down (arg)
  "Move window splitter down."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (shrink-window arg)
    (enlarge-window arg)))

(defun hydra-frame-shrink-left (arg)
  "Move window splitter left."
  (interactive "p")
  (set-frame-width (selected-frame) (- (frame-width) arg)))

(defun hydra-frame-grow-right (arg)
  "Move window splitter right."
  (interactive "p")
  (set-frame-width (selected-frame) (+ (frame-width) arg)))

(defun hydra-frame-shrink-up (arg)
  "Move window splitter up."
  (interactive "p")
  (set-frame-height (selected-frame) (- (frame-height) arg)))

(defun hydra-frame-grow-down (arg)
  "Move window splitter down."
  (interactive "p")
  (set-frame-height (selected-frame) (+ (frame-height) arg)))

(defhydra hydra-splitter-and-window (global-map "C-c e")
    "splitter"
    ("h" hydra-move-splitter-left)
    ("j" hydra-move-splitter-down)
    ("k" hydra-move-splitter-up)
    ("l" hydra-move-splitter-right)
    ("H" hydra-frame-shrink-left)
    ("J" hydra-frame-grow-down)
    ("K" hydra-frame-shrink-up)
    ("L" hydra-frame-grow-right))

(use-package hydra :ensure t)


(use-package ivy :ensure t
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil)
  (bind-key "C-r" 'counsel-expression-history read-expression-map)
  (bind-keys ("M-s s" . isearch-forward))
  :bind
  ("C-s" . swiper)
  ("C-x C-r" . ivy-resume))


(use-package ivy-hydra :ensure t)


(use-package ivy-pages :ensure t
  ;; bind to "j" because I want to use (i)menu and I'm an engineer :)
  :demand
  :bind
  ("C-c j" . ivy-pages)
  :bind (:map counsel-prefix-map
              ("j" . ivy-pages)))

(setq ivy-pages-keymap (make-sparse-keymap))
(bind-keys :map ivy-pages-keymap
           ("C-M-p" . ivy-previous-line)
           ("C-p" . ivy-previous-line-and-call)
           ("C-M-n" . ivy-next-line)
           ("C-n" . ivy-next-line-and-call))

(defun ivy-pages ()
  "Select buffer's pages via `ivy'."
  (interactive)
  (ivy-read "Pages: "
	    (ivy-pages-function)
	    :action (lambda (x)
		      (with-ivy-window
		      ;; Support both stable and unstable versions of Ivy 0.8.0
			(if (listp x)
			    (goto-char (cdr x))
			  (goto-char x))
			(recenter-top-bottom 0)))
	    :history 'ivy-pages-history
            :keymap ivy-pages-keymap
	    :require-match t
	    :caller 'ivy-pages))


(use-package ivy-xref :ensure t
       :init
       (setq xref-show-xrefs-function 'ivy-xref-show-xrefs))


(use-package linum :ensure t
  :config
  (setq linum-format " %3d ")
  (global-linum-mode -1)
  (add-hook 'prog-mode-hook 'linum-mode)
  (add-hook 'text-mode-hook 'linum-mode))


(use-package magit :defer t)

(defun magit-insert-last-fetch-time ()
  (let ((headfile (concat (vc-git-root default-directory) ".git/FETCH_HEAD")))
    (if (file-exists-p headfile)
        (let ((age (substring (shell-command-to-string (concat "stat -c %y " headfile)) 0 16)))
          (insert (format "Fetch:    %s\n" age)))
      (insert "Haven't fetched yet!!\n"))))

(use-package magit :ensure t
  :custom
  (magit-completing-read-function #'ivy-completing-read)
  (magit-log-arguments '("--graph" "--color" "--decorate" "--follow" "-n256"))
  (magit-status-sections-hook '(magit-insert-last-fetch-time
                                magit-insert-status-headers
                                magit-insert-merge-log
                                magit-insert-rebase-sequence
                                magit-insert-am-sequence
                                magit-insert-sequencer-sequence
                                magit-insert-bisect-output
                                magit-insert-bisect-rest
                                magit-insert-bisect-log
                                magit-insert-untracked-files
                                magit-insert-unstaged-changes
                                magit-insert-staged-changes
                                magit-insert-stashes
                                magit-insert-unpulled-from-upstream
                                magit-insert-unpulled-from-pushremote
                                magit-insert-unpushed-to-upstream-or-recent
                                magit-insert-unpushed-to-pushremote))
  (magit-status-show-hashes-in-headers t "Want to add more information")
  :bind
  (:prefix-map magit-prefix-map
               :prefix "C-x g"
               ("c" . magit-commit)
               ("e" . magit-ediff-resolve)
               ("l" . magit-log-popup)
               ("p" . magit-push)
               ("r" . magit-rebase-interactive)
               ("s" . magit-status)
               ("u" . magit-pull)
               ("x" . magit-checkout)
               ("L" . magit-diff-buffer-file))
  :bind
  (:map magit-mode-map
        ("o" . nil)
        ("O" . nil))
  :config
  (add-hook 'after-save-hook 'magit-after-save-refresh-status))


(use-package magit-filenotify :ensure t
  :config
  (add-hook 'magit-status-mode-hook 'magit-filenotify-mode))


(use-package magit-popup :ensure t)



(use-package man :ensure t
  :config
  (setq Man-width 90))


(use-package move-text :ensure t
  :bind
  ("M-n"      . move-text-down)
  ("M-p"      . move-text-up)
  ("<M-down>" . move-text-down)
  ("<M-up>"   . move-text-up))


(use-package multiple-cursors :ensure t
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


(use-package neotree :ensure t
  :config
  (setq neo-theme 'arrow
        neotree-smart-optn t
        neo-window-fixed-size nil))


(use-package page-break-lines :ensure t
  :config
  (global-page-break-lines-mode))


(use-package projectile :ensure t
  :demand
  :init
  (projectile-global-mode)
  :bind
  (:map projectile-command-map
        ("s a" . projectile-ag))
  :custom
  (projectile-cache-file (expand-file-name "projectile-cache" temp-dir) "use temp-dir for projectile-cache")
  (projectile-completion-system 'ivy "use ivy for completion")
  (projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" temp-dir) "set bookmarks")
  (projectile-switch-project-action #'projectile-vc "show vc when switching to project")
  (projectile-enable-idle-timer nil "turn on background stuff")
  (projectile-find-dir-includes-top-level t "allow you to switch to top level, very convenient"))


(use-package recentf :ensure t
  :config
  (setq recentf-save-file (recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))


(use-package restart-emacs :ensure t)


(use-package smartparens :ensure t
  :init
  (require 'smartparens-config)
  (smartparens-global-mode))


(use-package smex :ensure t)



(use-package string-inflection :ensure t)



(use-package treemacs :ensure t
  :config
  (require 'bgs-utils)
  (setq treemacs-show-hidden-files nil
	treemacs-file-event-delay 5000)
  (treemacs-filewatch-mode t)
  (treemacs-follow-mode t)
  (treemacs-git-mode 'simple)
  ;; configure mode map
  (add-name-to-map-and-key treemacs-mode-map "o a" "treemacs-ace-prefix")
  ;; mode hook
  (defun bgs-treemacs-mode-hook ()
    ;; (face-remap-add-relative 'hl-line :background "purple4")
    (setq cursor-type t))
  (add-hook 'treemacs-mode-hook #'bgs-treemacs-mode-hook)
  (add-hook 'treemacs-mode-hook #'treemacs-toggle-fixed-width))


(use-package treemacs-projectile :ensure t
  :bind
  ("<f8>" . treemacs-toggle)
  ("<f9>" . treemacs-projectile-toggle))


(use-package undo-tree :ensure t
  :config
  ;; Remember undo history
  (setq undo-tree-auto-save-history nil
        undo-tree-history-directory-alist `(("." . ,(concat temp-dir "/undo/"))))
  (global-undo-tree-mode 1))


(use-package vlf :ensure t)


(use-package wgrep :ensure t)


(use-package which-key :ensure t
  :init
  (setq which-key-mode-map (make-sparse-keymap))
  (bind-keys :map which-key-mode-map
	     :prefix-map which-key-prefix-map
	     :prefix "C-c W"
	     ("t" . which-key-show-top-level)
	     ("k" . which-key-show-keymap)
	     ("m" . which-key-show-minor-mode-keymap))
  (which-key-mode)
  :config
  (setq which-key-lighter ""
	which-key-popup-type 'side-window
	which-key-max-description-length 180
	which-key-side-window-max-height .50
	which-key-max-display-columns 1
	which-key-side-window-location (quote right)
	which-key-side-window-max-width 0.433))


(use-package windmove :ensure t
  :bind
  ("<C-up>" . windmove-up)
  ("<C-down>" . windmove-down)
  ("<C-left>" . windmove-left)
  ("<C-right>" . windmove-right))


(use-package yasnippet :ensure t
  :config
  (yas-global-mode 1))


(use-package zygospore :ensure t
  :bind
  ("C-x 1" . zygospore-toggle-delete-other-windows))



(provide '05-base-extensions)
