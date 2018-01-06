;; Require header
(use-package bind-key :ensure t)

;; Builtin Packages

(use-package autorevert :ensure t
  :config
  (global-auto-revert-mode)
  (setq global-auto-revert-non-file-buffers "t"))

(use-package hideshow :ensure t
  :config
  (add-hook 'prog-mode-hook 'hs-minor-mode))

(use-package ibuffer :ensure t
  :config
  (bind-keys ("C-x C-b" . ibuffer)))

(use-package vc :ensure t
  :config
  (require 'dash)
  (require 'vc-dir)

  (setq vc-log-show-limit 32)

  (defun bgs-vc-copy-marked-as-kill ()
    (interactive)
    (let ((string (s-join " " (vc-dir-marked-files))))
      (kill-new string)
      (message (format "Copied to kill ring: %s" string))))

  (defun bgs-vc-dir-at-root ()
    (interactive)
    (vc-dir (vc-root-dir)))

  (defun bgs-vc-dir-at-cwd ()
    (interactive)
    (vc-dir default-directory))

  (bind-key "w" 'bgs-vc-copy-marked-as-kill vc-dir-mode-map)

  (bind-key "C-x v" 'vc-prefix-map)

  (bind-keys :map vc-prefix-map
	     ("D" . bgs-vc-dir-at-root)
	     ("d" . bgs-vc-dir-at-cwd)))

(provide '04-base-modules)
