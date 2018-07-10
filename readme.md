# "Emacs Bootstrap"-Based Config!
- Jumping ship to check this out for a little
- [2017-04-18 Tue]

# Creating local package archive
```elisp
(let ((elpamr-default-output-directory "~/.emacs.d/myelpa"))
  (elpamr-create-mirror-for-installed))
```
- Emacs 26.1 doesn't work with melpa for whatever reason
- When archive is created though, 26.1 has no issue installing locally

# Environment Variables
- Should not be required!
- If not provided should act sanely

## EMACS_LOCAL_MODULE_PATH
- Specify path for the "local" module, this is loaded as is
- This defines a custom file and optionally a local.el that can be loaded

## EMACS_USE_LOCAL
- When set, use locally saved stuff!

## EMACS_USE_PYENV
- Thinking about this one
