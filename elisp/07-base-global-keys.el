;; Add your keys here, as such
;; Assume previous files have been sourced, not need to require or refer to them!
(require '06-base-functions)

(require 'bind-key)

(bind-key "C-h A" 'customize-group)
(bind-key "C-c h" 'hl-line-mode)

(bind-key "C-c r" 'visual-line-mode)

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

;; global keymaps: shells

;; run-prefix-map: inspired by projectile's command map
(setq run-prefix-map (make-sparse-keymap))
(bind-keys :map global-map
           :prefix-map run-prefix-map
           :prefix "C-c x"
           ("e" . eshell)
           ("p" . run-python)
           ("s" . shell)
           ("t" . term))



(provide '07-base-global-keys)
;;; 07-base-global-keys.el ends here
