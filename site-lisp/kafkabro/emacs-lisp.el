(defun kafkabro/emacs-f5 ()
  "revert buffer and then evaluate assumption is that generally
working with emacs files and you want a quick way to just refresh
the state of the sytem as it s currently described in the emacs
files"
  (interactive)
  (revert-buffer t nil)
  (eval-buffer)
  )

(defun kafkabro/emacs-lisp-mode-hook ()

  (local-set-key (kbd "<f5>") 'kafkabro/emacs-f5)
  (local-set-key (kbd "<f6>") 'eval-region)
  )

(add-hook 'emacs-lisp-mode-hook 'kafkabro/emacs-lisp-mode-hook)


(provide 'kafkabro/emacs-lisp)
