(use-package org :ensure t
  :init
  :mode
  ("\\.org.txt\\'" . org-mode)
  :config
  (setq org-M-RET-may-split-line nil)
  (setq org-agenda-custom-commands '(("p" "Punch card!" ((agenda "" nil) (tags "AUTOTIMER" nil)) nil nil) ("n" "Agenda (and )nd all TODOs" ((agenda "" nil) (alltodo "" nil)) nil)))
  (setq org-agenda-files nil)
  (setq org-agenda-ndays 1)
  (setq org-agenda-start-on-weekday nil)
  (setq org-clock-report-include-clocking-task t)
  (setq org-clock-rounding-minutes t)
  (setq org-cycle-open-archived-trees t)
  (setq org-default-notes-file (concat org-directory "/todo.org"))
  (setq org-insert-heading-respect-content t)
  (setq org-return-follows-link t)
  (setq org-startup-folded 'nofold)
  (setq org-time-clocksum-use-fractional t)
  (setq org-time-stamp-rounding-minutes '(6 6))
  (setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "|" "CANCEL(c)" "DONE(d)")))
  (org-babel-do-load-languages 'org-babel-load-languages '((python . t) (sh . t)))
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  :bind (:map org-mode-map ("C-c i" . counsel-org-goto)))

(use-package org-bullets :ensure t
  :demand
  :hook (org-mode . org-bullets-mode)
  :init
  (setq org-hide-leading-stars t))

(defun my-org-clocktable-indent-string (level)
  "Custom indent, operates on LEVEL."
  (if (= level 1)
      ""
    (let ((str "")
          (while (> level 2)
            (setq level (1- level)
                  str (concat str "--")))
          (concat str "-> ")))))
(advice-add 'org-clocktable-indent-string :override #'my-org-clocktable-indent-string)

;; (add-hook 'org-mode-hook 'org-bullets-mode)

(provide 'buff-org)
