(defvar org-agenda-keymap (make-sparse-keymap))

(use-package org :ensure t
  :init
  (org-babel-do-load-languages 'org-babel-load-languages '((python . t) (sh . t)))
  :custom
  (org-M-RET-may-split-line nil)
  (org-agenda-custom-commands '(("p" "Punch card!" ((agenda "" nil) (tags "AUTOTIMER" nil)) nil nil) ("n" "Agenda (and )nd all TODOs" ((agenda "" nil) (alltodo "" nil)) nil)))
  (org-agenda-files nil)
  (org-agenda-ndays 1)
  (org-agenda-start-on-weekday nil)
  (org-agenda-use-time-grid nil "no time grid by default")
  (org-clock-report-include-clocking-task t)
  (org-clock-rounding-minutes t)
  (org-cycle-open-archived-trees t)
  (org-default-notes-file (concat "~/todo.org"))
  (org-insert-heading-respect-content t)
  (org-return-follows-link t)
  (org-startup-folded 'nofold)
  (org-time-clocksum-use-fractional t)
  (org-time-stamp-rounding-minutes '(6 6))
  (org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "|" "CANCEL(c)" "DONE(d)")))
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
