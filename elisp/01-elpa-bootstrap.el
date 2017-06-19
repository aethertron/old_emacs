;; configure either local or remote elpa package archives

(package-initialize)

;; variables
(defcustom use-local (> (length (getenv "EMACS_USE_LOCAL")) 0) "build from local or web?")

(if use-local
    ;; use-local
    (progn
      (setq package-archives ())
      (add-to-list 'package-archives
		   ;; '("myelpa" . "http://localhost:8000/")) ;; works!
		   '("myelpa" . "~/.emacs.d/myelpa/"))
      ;; ("myelpa" . "https://raw.githubusercontent.com/redguardtoo/myelpa/master")
      package-archives)
   ;; use web
  (progn
    (setq package-archives ())
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
    (add-to-list 'package-archives '("elpy" . "http://jorgenschaefer.github.io/packages/"))
    ;; (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
    package-archives))

(when (not package-archive-contents)
  (package-refresh-contents))

(provide '01-elpa-bootstrap)
