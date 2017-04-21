(defun wgs-org-mode-hook ()
  (local-unset-key (kbd "<C-tab>")))

(add-hook 'org-mode-hook 'wgs-org-mode-hook)

(provide 'buff-org)
