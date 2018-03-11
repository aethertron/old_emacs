(defvar org-agenda-keymap (make-sparse-keymap))

(use-package org :ensure t
  :init
  (setq org-M-RET-may-split-line nil)
  (setq org-agenda-custom-commands '(("p" "Punch card!" ((agenda "" nil) (tags "AUTOTIMER" nil)) nil nil) ("n" "Agenda (and )nd all TODOs" ((agenda "" nil) (alltodo "" nil)) nil)))
  (setq org-agenda-files nil)
  (setq org-agenda-ndays 1)
  (setq org-agenda-start-on-weekday nil)
  (setq org-clock-report-include-clocking-task t)
  (setq org-clock-rounding-minutes t)
  (setq org-cycle-open-archived-trees t)
  (setq org-default-notes-file (concat "~/todo.org"))
  (setq org-insert-heading-respect-content t)
  (setq org-return-follows-link t)
  (setq org-startup-folded 'nofold)
  (setq org-time-clocksum-use-fractional t)
  (setq org-time-stamp-rounding-minutes '(6 6))
  (setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "|" "CANCEL(c)" "DONE(d)")))
  (org-babel-do-load-languages 'org-babel-load-languages '((python . t) (sh . t)))
  :mode
  ("\\.org.txt\\'" . org-mode)
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-'"   . nil)
  ("C-,"   . nil)

  :bind (:map org-mode-map ("C-c i" . counsel-org-goto))
  :bind (:map org-agenda-mode-map
              ("M-n" . org-agenda-next-item)
              ("M-p" . org-agenda-previous-item)))

(use-package org-bullets :ensure t
  :demand
  :hook (org-mode . org-bullets-mode)
  :init
  (setq org-hide-leading-stars t))

(defun my-org-clocktable-indent-string (level)
  "Custom indent, operates on LEVEL."
  (if (= level 1)
      ""
    (let ((str ""))
      (while (> level 2)
        (setq level (1- level)
              str (concat str "--")))
      (concat str "-> "))))
(advice-add 'org-clocktable-indent-string :override #'my-org-clocktable-indent-string)

(provide 'buff-org)
