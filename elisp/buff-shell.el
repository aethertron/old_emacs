(require 'shell)
(use-package bind-key)

(bind-key "M-p" 'comint-previous-matching-input-from-input shell-mode-map)
(bind-key "M-n" 'comint-next-matching-input-from-input shell-mode-map)

(provide 'buff-shell)
;;; buff-shell.el ends here
