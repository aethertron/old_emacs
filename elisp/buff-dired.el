(use-package dired+
  :config
  (setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^\\..*$"
	dired-listing-switches "-alh --group-directories-first")
  (bind-keys :map dired-mode-map
	     ("M-p" . dired-previous-line)
	     ("M-n" . dired-next-line)))

(defun wgs-dired-mode-hook ()
  (dired-omit-mode))
(add-hook 'dired-mode-hook 'wgs-dired-mode-hook)

(provide 'buff-dired)
