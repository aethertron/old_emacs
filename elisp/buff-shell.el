(require 'shell)
(use-package bind-key :ensure t)

(defun turn-on-comint-history (history-file)
  (setq comint-input-ring-file-name history-file)
  (comint-read-input-ring 'silent))

(add-hook 'shell-mode-hook (lambda () (turn-on-comint-history
				       (concat (getenv "HOME") "/.bash_history"))))

(provide 'buff-shell)
;;; buff-shell.el ends here
