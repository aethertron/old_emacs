(defun kafkalib/org-insert-current-time-stamp (ts_mode)
  "inserts org formatted time-stamp with current time, add prefix arg for active"
  (interactive "p")
  (if (= ts_mode 1)  (org-insert-time-stamp (current-time) "t" 1)
    (if (= ts_mode 4) (insert (format-time-string "%Y-%m-%d"))
      (insert (substring (format-time-string (org-time-stamp-format 1 1)) 1 -1)))))


(defun kafkalib/launch-shell (arg)
  "launches a shell with a unique name"
  (interactive "P")
  (shell (concat  (substring (pwd) 10))))

(provide 'kafkalib/etc)
