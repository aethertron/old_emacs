(setq dired-dwim-target t)

(use-package dired+ :ensure t
  :config
  (setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^\\..*$"
	dired-listing-switches "-alh --group-directories-first")
  (bind-keys :map dired-mode-map
	     ("M-p" . dired-previous-line)
	     ("M-n" . dired-next-line)))

(defun wgs-dired-mode-hook ()
  (let ((prev-omit dired-omit-verbose))
    (setq dired-omit-verbose nil)
    (dired-omit-mode)
    (setq dired-omit-verbose prev-omit)))

(setq dired-mode-hook (last dired-mode-hook (- (length dired-mode-hook) 1)))
(add-hook 'dired-mode-hook 'wgs-dired-mode-hook)

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

(provide 'buff-dired)
