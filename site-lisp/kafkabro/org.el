;; kafkabro's org config
;; * org-mode begin
(require 'org)
(require 'kafkalib/etc)
;; (require 'org-habit)

;; *** add stuff
(global-set-key (kbd "C-c l") 'org-store-link) ; suggested in http://orgmode.org/manual/Handling-links.html
(global-set-key (kbd "C-c s") 'kafkalib/org-insert-current-time-stamp)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c C-x .") 'org-timer)
(global-set-key (kbd "C-c C-x 0") 'org-timer-start)


;; ** babel config
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . t)
   (js . t)
   (sh . t)
   (org . t)
   ;; *** diagraming langs
   (ditaa . t)
   (plantuml . t)))

;; default to make sensible archive
(setq org-archive-default-command 'org-archive-to-archive-sibling)

;; ** org-mode hook
(defun kafkabro/org-map-disputed-keys ()
  "my own version of dispute keys since the org interface 
doesn't appear to be working"
  ;; up map contested
  (local-unset-key (kbd "<S-up>"))
  (local-unset-key (kbd "<S-down>"))
  (local-unset-key (kbd "<S-left>"))
  (local-unset-key (kbd "<S-right>"))
  (local-unset-key (kbd "<C-S-left>"))
  (local-unset-key (kbd "<C-S-right>"))
  (local-unset-key (kbd "<C-tab>"))	; unmap force cycled
  ;; remap contested
  (local-set-key (kbd "M-P") 'org-shiftup)
  (local-set-key (kbd "M-N") 'org-shiftdown)
  (local-set-key (kbd "M-[") 'org-shiftleft )
  (local-set-key (kbd "M-]") 'org-shiftright )
  (local-set-key (kbd "C-M-{") 'org-shiftcontrolleft )
  (local-set-key (kbd "C-M-}") 'org-shiftcontrolright )
  (local-set-key (kbd "M-8") 'org-force-cycle-archived)
  )

(defun kafkabro/org-mode-hook ()
  ;; org-specific minor modes
  (org-indent-mode)
  ;; 
  (local-set-key (kbd "C-c a") 'org-agenda)
  (local-set-key (kbd "<C-tab>") 'next-multiframe-window)
  ;;
  (kafkabro/org-map-disputed-keys)
  ;;
  (local-set-key (kbd "C-8") 'org-cycle)
  (local-set-key (kbd "C-*") 'org-global-cycle)
  )

(add-hook 'org-mode-hook 'kafkabro/org-mode-hook)
;; * org-mode end 

(provide 'kafkabro/org)
