;; added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; add elisp lib to path before loading scripts!
(add-to-list 'load-path (concat user-emacs-directory "elisp-lib"))

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require '01-elpa-bootstrap)
(require '02-base)
(require '03-base-theme)
(require '04-base-modules)
(require '05-base-extensions)
(require '06-base-functions)
(require '07-base-global-keys)
(require '08-all-packages)

;; following should be written so that they can be imported in any order!
(require 'lang-python)
(require 'lang-javascript)
(require 'lang-web)
(require 'lang-c)
(require 'lang-markdown)

;; other major modes such as dired buffers
(require 'buff-dired)
(require 'buff-org)
(require 'buff-shell)

;; back-up and create local copy if not using local already
(add-to-list 'load-path "~/.emacs.d/elisp-pkgs/elpa-mirror")
(require 'elpa-mirror)



(provide '00-init)
