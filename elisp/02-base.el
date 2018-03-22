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
(setq auto-window-vscroll                      nil)
(setq confirm-kill-emacs                       'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer       t)
(setq cursor-in-non-selected-windows           nil)
(setq exec-path                                (append exec-path '("/usr/local/bin/")))
(setq fringes-outside-margins                  t)
(setq highlight-nonselected-windows            nil)
(setq indent-tabs-mode                         nil)
(setq inhibit-startup-message                  t)
(setq minibuffer-prompt-properties             '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))
(setq mouse-yank-at-point                      t)
(setq require-final-newline                    t)
(setq ring-bell-function                       'ignore)
(setq save-interprogram-paste-before-kill      t)
(setq select-enable-clipboard                  t)
(setq visible-bell                             nil)

(setq-default fill-column 84)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default truncate-lines t)

;; Unlock disabled features
(put 'narrow-to-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Custom
(setq custom-file                              "~/.emacs.d/local/custom.el")
(load custom-file 'noerror)

;; Bookmarks
(setq bookmark-save-flag                      t)
(setq bookmark-default-file                   (concat temp-dir "/bookmarks"))

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


;; ;;; basic display / window config
;; Looks like 25.1 doesn't properly handle make-frame properly, width and heigh not setting correctly
(defun wgs--rearranged ()
  (interactive)
  (set-frame-height (selected-frame) 40)
  (set-frame-width (selected-frame) 120))
;; (add-hook 'window-configuration-change-hook #'wgs--rearranged) this slows things down immensely, abort
;; (add-hook 'window-setup-hook #'wgs--rearranged) note: this doesn't work!


;;; comint section
(require 'comint)
(bind-keys :map comint-mode-map
           ("C-c C-b" . comint-previous-prompt)
           ("C-c C-f" . comint-next-prompt)
           ("M-p" . comint-previous-matching-input-from-input)
           ("M-n" . comint-next-matching-input-from-input))
;; Write comint input rings (for history, etc) when buffers are killed
(use-package dash :ensure t)
(add-hook 'kill-buffer-hook #'comint-write-input-ring)
(add-hook 'kill-emacs-hook (lambda () (--each (buffer-list) (with-current-buffer it (comint-write-input-ring)))))


;; Truncate Lines Mode Config
(defun truncate-lines-mode ()
  (toggle-truncate-lines 1))

;; async mode command config
(require 'simple)
(setq async-shell-command-buffer 'new-buffer)


;; elisp mode config
(bind-keys :map emacs-lisp-mode-map
           ("C-M-i" nil))


;; fix for enriched mode part of Emacs 25.3 release, bug described here: https://www.gnu.org/software/emacs/news/NEWS.25.3
(eval-after-load "enriched"
    '(defun enriched-decode-display-prop (start end &optional param)
       (list start end)))



(provide '02-base)
;;; base ends here
