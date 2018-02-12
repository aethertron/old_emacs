(use-package markdown-mode :ensure t
  :mode "\\.txt\\'"
  :init
  ;; Note: must install markdown-it using npm, supports tables unlike markdown prog
  (setq markdown-command "markdown-it"))

(provide 'lang-markdown)
;;; lang-markdown.el ends here
