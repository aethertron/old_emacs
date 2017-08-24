(use-package dired+
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

(provide 'buff-dired)
