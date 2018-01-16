;; configure baseline/builtin stuff
;; Core settings



(defconst private-dir  (expand-file-name "private" user-emacs-directory))
(defconst temp-dir (format "%s/cache" private-dir)
  "Hostname-based elisp temp directories")

(server-start)


;; UTF-8 please
(set-charset-priority 'unicode)
(setq locale-coding-system   'utf-8)   ; pretty
(set-terminal-coding-system  'utf-8)   ; pretty
(set-keyboard-coding-system  'utf-8)   ; pretty
(set-selection-coding-system 'utf-8)   ; please
(prefer-coding-system        'utf-8)   ; with sugar on top
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Emacs customizations
(setq confirm-kill-emacs                  'y-or-n-p
      confirm-nonexistent-file-or-buffer  t
      save-interprogram-paste-before-kill t
      mouse-yank-at-point                 t
      require-final-newline               t
      visible-bell                        nil
      ring-bell-function                  'ignore
      custom-file                         "~/.emacs.d/.custom.el"
      ;; http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
      minibuffer-prompt-properties
      '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)
      ;; Disable non selected window highlight
      cursor-in-non-selected-windows     nil
      highlight-nonselected-windows      nil
      ;; PATH
      exec-path                          (append exec-path '("/usr/local/bin/"))
      indent-tabs-mode                   nil
      inhibit-startup-message            t
      fringes-outside-margins            t
      select-enable-clipboard            t
      use-package-always-ensure          t) ; finding always ensure doesn't work
(setq-default indent-tabs-mode nil
	      fill-column 84
              tab-width 4)

;; Unlock disabled features
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'scroll-left 'disabled nil)

;; Bookmarks
(setq
 ;; persistent bookmarks
 bookmark-save-flag                      t
 bookmark-default-file              (concat temp-dir "/bookmarks"))

;; Backups enabled, use nil to disable
(setq
 history-length                     1000
 backup-inhibited                   nil
 make-backup-files                  t
 auto-save-default                  t
 auto-save-list-file-name           (concat temp-dir "/autosave")
 make-backup-files                  t
 create-lockfiles                   nil
 backup-directory-alist            `((".*" . ,(concat temp-dir "/backup/")))
 auto-save-file-name-transforms    `((".*" ,(concat temp-dir "/auto-save-list/") t)))

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)

;; Disable toolbar & menubar
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (  fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(show-paren-mode 1)

(column-number-mode 1)

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Recursive minibuffer
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode)

;; dired and friends
(require 'dired-x)
(require 'alist)
(setq dired-guess-shell-alist-user nil)
(setq dired-guess-shell-alist-user (put-alist "\\.pdf\\'" '("okular") dired-guess-shell-alist-user))
(setq dired-guess-shell-alist-user (put-alist "\\.html\\'" '("google-chrome") dired-guess-shell-alist-user))
(setq dired-guess-shell-alist-user (put-alist "\\.png\\'" '("gwenview") dired-guess-shell-alist-user))
(setq dired-guess-shell-alist-user (put-alist "\\.jpe?g\\'" '("gwenview") dired-guess-shell-alist-user))
;; another way to add alist elements
(add-to-list 'dired-guess-shell-alist-user (list ".*" "xdg-open") "t")

;; Write comint input rings (for history, etc) when buffers are killed
(use-package dash :ensure t)
(require 'comint)
(add-hook 'kill-buffer-hook #'comint-write-input-ring)
(add-hook 'kill-emacs-hook (lambda () (--each (buffer-list)
			     (with-current-buffer it (comint-write-input-ring)))))



(provide '02-base)
;;; base ends here
