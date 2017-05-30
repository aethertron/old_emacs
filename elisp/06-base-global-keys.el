;; Add your keys here, as such
;; Assume previous files have been sourced, not need to require or refer to them!

(require 'bind-key)

(bind-key "<C-tab>" 'next-multiframe-window)
(bind-key "<C-S-iso-lefttab>" 'previous-multiframe-window)
(bind-key "C-h A" 'customize-group)
(bind-key "C-c h" 'hl-line-mode)

(bind-key "C-c x" 'shell)

(bind-key "<f5>" 'revert-buffer)

(bind-key "C-o" 'bgs-open-next-line)
(bind-key "C-S-o" 'bgs-open-prev-line)

(bind-key "C-c i" 'imenu)

(bind-key "C-z" nil)

(provide '06-base-global-keys)
;;; 06-base-global-keys.el ends here
