;; Add your keys here, as such
;; Assume previous files have been sourced, not need to require or refer to them!
(require '06-base-functions)

(require 'bind-key)

(bind-key "C-h A" #'customize-group)
(bind-key "C-c h" #'hl-line-mode)

(bind-key "C-c r" #'visual-line-mode)

(bind-key "<f5>" #'revert-buffer)
(bind-key "M-\\" #'bgs-shell-command-on-buffer)

(bind-key "C-o" #'bgs-open-next-line)
(bind-key "C-M-o" #'bgs-open-prev-line) ; replaces "split-line"
(bind-key "C-S-o" #'split-line)         ; x-win-only binding, make seldomly used split-line available there

(bind-key "C-c i" #'imenu)
(bind-key "C-c m" #'man)
(bind-key "C-c w" #'bgs-copy-buffer-file-name)

(bind-key "C-z" nil)

(bind-key "C-c q" #'wgs--rearranged)

(bind-key "C-c t" #'insert-iso-timestamp)

;; Complement to C-x C-e
(bind-key "C-c C-e" #'sh-execute-region)

;; swap C-a and M-m
(bind-key "C-a" nil)
(bind-key "M-m" nil)
(bind-key "C-a" #'back-to-indentation)
(bind-key "M-m" #'move-beginning-of-line)

;; kill-whole-line: introduce binding that can be used
;;   with character device (such as terminal/konsole/xterm)
;;   as well as in Emacs
(bind-key "M-K" #'kill-whole-line)

;; no longer swap completion and expand!
(bind-key "M-/" #'dabbrev-expand)
(bind-key "C-M-/" #'dabbrev-completion)

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
