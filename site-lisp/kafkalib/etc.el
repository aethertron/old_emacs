(defun kafkalib/org-insert-current-time-stamp (is_active)
  "inserts org formatted time-stamp with current time, add prefix arg for active"
  (interactive "P")
  (org-insert-time-stamp (current-time) "t" (not is_active)))

(provide 'kafkalib/etc)
