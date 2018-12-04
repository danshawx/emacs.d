

;;(add-to-list 'load-path "f:/emacs/.emacs.d/elpa/dired")
(add-to-list 'load-path "~/.emacs.d/elpa/dired")

(require 'dired+)

;; (require-package 'dired+)

(after-load 'dired
  (require 'dired+)
  (toggle-diredp-find-file-reuse-dir 1)
  (setq dired-recursive-deletes 'top))

(provide 'init-dired)
