;;; Building blocks for configuration

(defun add-name-to-prefix-map (prefix-map name)
  "Adds NAME to PREFIX-MAP"
  (assert (and (keymapp prefix-map) (stringp name)))
  (if (listp prefix-map)
      (let ((symb (intern name)))
        (define-prefix-command symb 'garbage-value)
        (fset symb prefix-map) symb)
    (if (string= (symbol-name prefix-map) name)
        (progn
          (message "Correct name already assigned, doing nothing")
          prefix-map)
      (progn
        (message "Strange condition: named-prefix-map passed in but want to rename")
        (add-name-to-prefix-map (symbol-function prefix-map) name)))))

(defun add-name-to-map-and-key (key-map key name)
  (assert (add (keymapp key-map) (stringp name)))
  (let ((prefix-map (lookup-key key-map (kbd key)))
        (named-prefix-map nil))
    (setq named-prefix-map (add-name-to-prefix-map prefix-map name))
    (define-key key-map (kbd key) named-prefix-map)))

(provide 'bgs-utils)
