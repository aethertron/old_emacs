;; Add your custom functions here
;; requires bind-key / use-package, just assume it's there!


(defun bgs-open-next-line (arg)
  "Move to next line and then open line, vi-style. ARG: number of lines"
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (forward-line 1)
  (indent-according-to-mode))

(defun bgs-open-prev-line (arg)
  "Move to prev line and then open line, vi-style. ARG: number of lines"
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (indent-according-to-mode))

(defun bgs-copy-buffer-file-name ()
  (interactive)
  (kill-new (buffer-file-name))
  (message (format "Copied \"%s\" to kill-ring" (buffer-file-name))))

(defun bgs-shell-command-on-buffer ()
  "Asks for a command and executes it in inferior shell with current buffer
as input."
  (interactive)
  (shell-command-on-region
   (point-min) (point-max)
   (read-shell-command "Shell command on buffer: ")))



;;; INSERT COMMANDS
(defconst iso-timestamp-format-date-and-time "%Y-%m-%d, %H:%M")
(defconst iso-timestamp-format-date "%Y-%m-%d")

(defun insert-iso-timestamp ()
  (interactive)
  (insert (format-time-string iso-timestamp-format-date-and-time)))

(provide '06-base-functions)
