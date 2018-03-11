;; Require header
(use-package bind-key :ensure t)
;; Builtin Packages



(use-package autorevert :ensure t
  :init
  (setq auto-revert-verbose nil)
  (setq global-auto-revert-non-file-buffers "t")
  (global-auto-revert-mode))


(use-package eshell :defer t)
;; eshell

(defvar eshell-extra-minor-mode-map (make-sparse-keymap))
(define-minor-mode eshell-extra-minor-mode
  :global nil :keymap eshell-extra-minor-mode-map)
(add-hook 'eshell-extra-minor-mode-hook #'truncate-lines-mode)

(use-package eshell
  :init
  ;; prompt function
  (defun eshell-prompt-bgs ()
    (concat (format-time-string "[%H:%M:%S] " (current-time))
            (if (= (user-uid) 0) " # " " $ ")))
  (defvar eshell-prompt-function #'eshell-prompt-bgs)
  ;; minor mode for key config
  :bind (:map eshell-extra-minor-mode-map)
  ("C-a" . eshell-bol)
  ("M-m" . eshell-bol)
  :hook (eshell-mode . eshell-extra-minor-mode)
  :config
  (eval-after-load "counsel"
    '(progn
       (bind-keys :map eshell-extra-minor-mode-map
                  ("M-r" . counsel-esh-history)
                  ("C-c C-f" . eshell-next-prompt)
                  ("C-c C-b" . eshell-previous-prompt)))))


(use-package hideshow :ensure t
  :config
  (add-hook 'prog-mode-hook 'hs-minor-mode))


(use-package ibuffer :ensure t
  :config
  (bind-keys ("C-x C-b" . ibuffer)))


(use-package sort :ensure t
  :init
  (defvar sort-prefix-map (make-sparse-keymap))
  :bind
  ("C-c s" . sort-lines)
  :bind
  (:prefix-map sort-prefix-map
               :prefix "C-c S"
               ("s" . sort-lines)
               ("p" . sort-pages)
               ("f" . sort-fields)
               ("c" . sort-columns)
               ("g" . sort-paragraphs)
               ("r" . sort-regexp-fields)
               ("n" . sort-numeric-fields)))


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


(use-package xref
  :bind
  (:map xref--xref-buffer-mode-map
        ("M-n" . xref-next-line)
        ("M-p" . xref-prev-line)))



(provide '04-base-modules)
