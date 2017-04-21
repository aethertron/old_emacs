;; Add your keys here, as such
;; Assume previous files have been sourced, not need to require or refer to them!

;(global-set-key (kbd "[SHORTCUT]") '[FUNCTION])
(global-set-key (kbd "<C-tab>") 'next-multiframe-window)
(global-set-key (kbd "<C-S-iso-lefttab>") 'previous-multiframe-window)
(global-set-key (kbd "C-h A") 'customize-group)
(global-set-key (kbd "C-c h") 'hl-line-mode)

(global-set-key (kbd "C-c x") 'shell)

(define-key global-map [remap open-line] 'wgs-open-next-line)
(define-key global-map (kbd "C-S-o") 'wgs-open-prev-line)

(provide '06-base-global-keys)
