(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(buffer-move-behavior (quote move))
 '(dired-hide-details-hide-information-lines t)
 '(dired-listing-switches "-Alh")
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(helm-split-window-default-side (quote right))
 '(ido-use-virtual-buffers (quote auto))
 '(magit-log-arguments
   (quote
    ("--graph" "--color" "--decorate" "--patch" "-n256")))
 '(menu-bar-mode nil)
 '(org-M-RET-may-split-line nil)
 '(org-agenda-dim-blocked-tasks nil)
 '(org-agenda-files "~/.emacs.d/site-lisp/org-agenda-files")
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-skip-timestamp-if-done t)
 '(org-agenda-span (quote week))
 '(org-agenda-start-on-weekday nil)
 '(org-archive-reversed-order t)
 '(org-capture-after-finalize-hook nil)
 '(org-capture-templates
   (quote
    (("c" "feed cats" table-line
      (file+olp "~/org/cats.org" "Cat Maintenance" "Feed Cats Twice Daily")
      "|%U|1/2|1/2|no|1/3|1/3|no|standard|separated |" :table-line-pos "I+1")
     ("w" "weight" table-line
      (file+headline "~/org/body.org" "Weight")
      "|#|%U|%^{weight}| " :table-line-pos "I+1"))))
 '(org-catch-invisible-edits (quote show))
 '(org-clock-clocked-in-display (quote both))
 '(org-clock-in-switch-to-state "DOING")
 '(org-clock-into-drawer nil)
 '(org-clock-mode-line-total (quote current))
 '(org-clock-out-switch-to-state "PAUSE")
 '(org-columns-skip-archived-trees nil)
 '(org-completion-use-ido t)
 '(org-confirm-babel-evaluate nil)
 '(org-disputed-keys
   (quote
    (([(shift up)]
      .
      [(meta shift p)])
     ([(shift down)]
      .
      [(meta shift n)])
     ([(shift left)]
      .
      [(meta \[)])
     ([(shift right)]
      .
      [(meta \])])
     ([(control shift right)]
      .
      [(meta control \[)])
     ([(control shift left)]
      .
      [(meta control \])]))))
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-enforce-todo-dependencies t)
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "okular %s"))))
 '(org-goto-max-level 5)
 '(org-habit-following-days 2)
 '(org-insert-heading-respect-content t)
 '(org-log-into-drawer t)
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 3))))
 '(org-replace-disputed-keys t)
 '(org-return-follows-link t)
 '(org-reverse-note-order t)
 '(org-sparse-tree-open-archived-trees t)
 '(org-special-ctrl-a/e t)
 '(org-startup-align-all-tables t)
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t!)" "STARTED(s!)" "BLOCKED(b@/!)" "DOING(d)" "PAUSE(p)" "|" "DONE(o!)" "CANCEL(x@)"))))
 '(org-treat-insert-todo-heading-as-state-change t)
 '(revert-without-query (quote (".*")))
 '(shell-file-name "/usr/bin/tcsh")
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
