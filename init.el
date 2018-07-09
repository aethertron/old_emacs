;;; package --- Main init file
;;; Commentary:
;;; This is my init file

;;; Code:



;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; determine local module path: used for costum and for loading after init

(defconst local-module-path
  (let ((raw-path (if (not (getenv "EMACS_LOCAL_MODULE_PATH"))
                    (concat user-emacs-directory "local" "/")
                    (getenv "EMACS_LOCAL_MODULE_PATH"))))
    (if (string= (substring raw-path -1) "/") raw-path (concat raw-path "/")))
  "Path of the local variable used for custom and post-load stuff should end with '/'")

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
(require '00-init)

;;  load the local module, place for version-controlled site-specific stuff
(let* ((local-filename (expand-file-name "local.el" local-module-path)))
  (when (file-exists-p local-filename)
    (add-to-list 'load-path local-module-path)
    (require 'local)))
