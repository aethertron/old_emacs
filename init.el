;;; package --- Main init file
;;; Commentary:
;;; This is my init file

;;; Code:



;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
(require '00-init)

;;  load the local moudle, place for version-controlled site-specific stuff
(let* ((local-feature "local")
       (local-path (concat user-emacs-directory local-feature "/"))
       (local-filename (concat local-path local-feature ".el")))
  (when (file-exists-p local-filename)
    (add-to-list 'load-path local-path)
    (require 'local)))
