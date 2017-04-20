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

(require 'elpa-bootstrap)
(require 'base)

;; local packages (may rely on other pkgs, install after elpa)
(add-to-list 'load-path "~/.emacs.d/elisp-pkgs/elpa-mirror")
(require 'elpa-mirror)

;; ;; test code here
;; (package-install 'ivy)
;; (require 'ivy)
;; (ivy-mode)

(require 'base-theme)
(require 'base-extensions)
(require 'base-functions)
(require 'base-global-keys)

(require 'lang-python)
(require 'lang-javascript)
(require 'lang-web)
(require 'lang-c)

;; back-up and create local copy if not using local already
(if (null use-local)
    (progn
      (setq elpamr-default-output-directory "~/.emacs.d/myelpa")
      (elpamr-create-mirror-for-installed)))
