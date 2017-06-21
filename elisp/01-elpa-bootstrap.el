;; configure either local or remote elpa package archives

(package-initialize)

;; variables
(defcustom use-local (> (length (getenv "EMACS_USE_LOCAL")) 0) "build from local or web?")

(if use-local
    ;; use-local
    (progn
      (setq package-archives ())
      (add-to-list 'package-archives
		   '("myelpa" . "~/.emacs.d/myelpa/"))
      package-archives)
   ;; use web
  (progn
    (setq package-archives ())
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
    (add-to-list 'package-archives '("elpy" . "http://jorgenschaefer.github.io/packages/"))
    package-archives))

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(provide '01-elpa-bootstrap)
