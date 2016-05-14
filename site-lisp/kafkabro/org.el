;; kafkabro's org config
;; * org-mode begin
(require 'org)
;; (require 'org-habit)

;; *** add stuff
(global-set-key (kbd "C-c l") 'org-store-link) ; suggested in http://orgmode.org/manual/Handling-links.html

;; ** agenda config
(setq org-agenda-files '("~/org" "~/org.spideroak"))
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

;; ** org-mode hook
(defun kafkabro/org-mode-hook ()
  ;; org-specific minor modes
  (org-indent-mode)
  ;; local key map removals
  (local-unset-key (kbd "RET")) 		      ; unmap org-return
  (local-unset-key (kbd "M-RET"))		      ; unmap org-insert-heading
  ;; local key map additions
  (local-set-key (kbd "RET") 'org-insert-heading)     ; unmap 
  (local-set-key (kbd "M-RET") 'org-return)           ; unmap 
  ;; 
  (local-set-key (kbd "C-c a") 'org-agenda)
  (local-set-key (kbd "<C-tab>") 'next-multiframe-window)
  )
(add-hook 'org-mode-hook 'kafkabro/org-mode-hook)
;; * org-mode end 

(provide 'kafkabro/org)
