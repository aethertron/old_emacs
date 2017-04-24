(use-package org
  :config
  (setq org-directory "~/org-files"
	org-agenda-files (list (concat org-directory "/agenda"))
        org-default-notes-file (concat org-directory "/todo.org")
	org-clock-report-include-clocking-task "t"
	org-time-clocksum-use-fractional "t"
	org-agenda-start-on-weekday nil
	org-agenda-ndays 1
	org-agenda-custom-commands
	(quote
	 (("p" "Punch card!"
	   ((agenda "" (not )il)
	    (tags "AUTOTIMER" nil))
	   nil nil)
	  ("n" "Agenda (and )nd all TODOs"
	   ((agenda "" nil)
	    (alltodo "" nil))
	   nil))))
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda))

(use-package org-projectile
  :config
  (org-projectile:per-repo)
  (setq org-projectile:per-repo-filename "todo.org"
	org-agenda-files (append org-agenda-files (org-projectile:todo-files))))

(use-package org-bullets
  :config
  (setq org-hide-leading-stars t)
  (add-hook 'org-mode-hook
            (lambda ()
              (org-bullets-mode t))))

(defun wgs-org-mode-hook ()
  (local-unset-key (kbd "<C-tab>")))

(add-hook 'org-mode-hook 'wgs-org-mode-hook)

(provide 'buff-org)
