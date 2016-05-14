(defun kafkabro/emacs-f5 ()
  (interactive)
  (revert-buffer t nil)
  (eval-buffer)
  )

(defun kafkabro/emacs-lisp-mode-hook ()
  (local-set-key (kbd "<f5>") 'kafkabro/emacs-f5)
  )

(add-hook 'emacs-lisp-mode-hook 'kafkabro/emacs-lisp-mode-hook)


(provide 'kafkabro/emacs-lisp)
