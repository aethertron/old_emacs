;; Add your keys here, as such
;; Assume previous files have been sourced, not need to require or refer to them!
(require '06-base-functions)

(require 'bind-key)

(bind-key "<C-tab>" 'next-multiframe-window)
(bind-key "<C-S-iso-lefttab>" 'previous-multiframe-window)
(bind-key "C-h A" 'customize-group)
(bind-key "C-c h" 'hl-line-mode)

(bind-key "C-c x" 'shell)
(bind-key "C-c r" 'toggle-truncate-lines)

(bind-key "<f5>" 'revert-buffer)
(bind-key "M-\\" 'bgs-shell-command-on-buffer)

(bind-key "C-o" 'bgs-open-next-line)
(bind-key "C-S-o" 'bgs-open-prev-line)

(bind-key "C-c i" 'imenu)
(bind-key "C-c m" 'man)
(bind-key "C-c w" 'bgs-copy-buffer-file-name)

(bind-key "C-z" nil)

;; swap C-a and M-m
(bind-key "C-a" nil)
(bind-key "M-m" nil)
(bind-key "C-a" 'back-to-indentation)
(bind-key "M-m" 'move-beginning-of-line)

(provide '07-base-global-keys)
;;; 07-base-global-keys.el ends here
