(use-package dired+
  :config
  (setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^\\..*$")
  (setq dired-listing-switches "-alh --group-directories-first"))

(defun wgs-dired-mode-hook ()
  (dired-omit-mode))
(add-hook 'dired-mode-hook 'wgs-dired-mode-hook)

(provide 'buff-dired)
