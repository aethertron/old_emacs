(setq dired-dwim-target t)
(setq dired-listing-switches "-alh --group-directories-first")
(setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^\\..*$")
(setq dired-omit-verbose nil)

(defun dired-find-file-extern ()
  (interactive)
  (let ((find-file-run-dired t))
    (counsel-locate-action-extern (dired-get-file-for-visit))))

(bind-keys :map dired-mode-map
	       ("M-p" . dired-previous-line)
	       ("M-n" . dired-next-line)
           ("e" . dired-find-file-extern))

(use-package dired+ :ensure t)


(require 'dired-x)
;; dired-x section
(add-hook 'dired-mode-hook 'dired-omit-mode)

(require 'alist)
(setq dired-guess-shell-alist-user nil)
(setq dired-guess-shell-alist-user (put-alist "\\.pdf\\'" '("okular") dired-guess-shell-alist-user))
(setq dired-guess-shell-alist-user (put-alist "\\.html\\'" '("google-chrome") dired-guess-shell-alist-user))
(setq dired-guess-shell-alist-user (put-alist "\\.png\\'" '("gwenview") dired-guess-shell-alist-user))
(setq dired-guess-shell-alist-user (put-alist "\\.jpe?g\\'" '("gwenview") dired-guess-shell-alist-user))
;; another way to add alist elements
(add-to-list 'dired-guess-shell-alist-user (list ".*" "xdg-open") "t")

(provide 'buff-dired)
