(defun markdown-show-level-1 () (interactive) (markdown-hide-sublevels 1))
(defun markdown-show-level-2 () (interactive) (markdown-hide-sublevels 2))
(defun markdown-show-level-3 () (interactive) (markdown-hide-sublevels 3))

(use-package markdown-mode :ensure t
  :mode "\\.txt\\'"
  :custom
  ;; Note: must install markdown-it using npm, supports tables unlike markdown prog
  (markdown-command "markdown-it")
  :config
  (bind-keys :map markdown-mode-map
             ("M-1" . markdown-show-level-1)
             ("M-2" . markdown-show-level-2)
             ("M-3" . markdown-show-level-3)
             ("M-4" . markdown-show-all)))

(provide 'lang-markdown)
;;; lang-markdown.el ends here
