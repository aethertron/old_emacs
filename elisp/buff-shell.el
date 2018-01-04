(require 'shell)
(use-package bind-key)

(bind-key "M-p" 'comint-previous-matching-input-from-input shell-mode-map)
(bind-key "M-n" 'comint-next-matching-input-from-input shell-mode-map)

(defun turn-on-comint-history (history-file)
  (setq comint-input-ring-file-name history-file)
  (comint-read-input-ring 'silent))

(add-hook 'shell-mode-hook (lambda () (turn-on-comint-history
				       (concat (getenv "HOME") "/.bash_history"))))

(provide 'buff-shell)
;;; buff-shell.el ends here
