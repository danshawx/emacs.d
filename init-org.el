;;(add-to-list 'load-path "f:/emacs/.emacs.d/elpa/org-fstree")
(add-to-list 'load-path "~/.emacs.d/elpa/org-fstree")

(require 'org-fstree)
;;(require-package 'org-fstree)
(require-package 'orgit)
(require-package 'toc-org)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

;; Various preferences
(setq org-log-done t
      org-completion-use-ido t
      org-edit-timestamp-down-means-later t
      org-agenda-start-on-weekday nil
      org-agenda-span 14
      org-agenda-include-diary t
      org-agenda-window-setup 'current-window
      org-fast-tag-selection-single-key 'expert
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80
      org-startup-indented t)

;; add==================================================
(setq 
      ;; turn on the syntax highlight in the org mode
      org-src-fontify-natively t 
      ;; when exporting the org file, do not evaluate the code block if the exports header is both
      org-export-babel-evaluate nil 
      ;; skip the confirmation step when evaluate a code block
      org-confirm-babel-evaluate nil)

;; Include the latex-exporter
(require 'ox-latex)
;; Add minted to the defaults packages to include when exporting.
;; set snippet-flat to nil to exclude minted for latex preview
;; see http://orgmode.org/worg/org-tutorials/org-latex-preview.html
(add-to-list 'org-latex-packages-alist '("" "minted" nil))
;; Tell the latex export to use the minted package for source
;; code coloration.
(setq org-latex-listings 'minted)
;; Let the exporter use the -shell-escape option to let latex
;; execute external programs.
;; This obviously and can be dangerous to activate!
;; multiple compile in order to generate everything
(setq org-latex-pdf-process
      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
;;=========================================================

; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))
; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
                                (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persistence-insinuate t)
(setq org-clock-persist t)
(setq org-clock-in-resume t)

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(eval-after-load 'org-clock
  '(progn
     (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
     (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu)))

(after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (emacs-lisp . t)
     (gnuplot . t)
     (haskell . nil)
     (latex . t)
     (octave . t)
     (python . t)
     (ruby . t)
     (shell . t))))

;; use org-toc
(add-hook 'org-mode-hook 'toc-org-enable)

;; enable markdown-exporting to the export menu
(eval-after-load "org"
  '(require 'ox-md nil t))

(provide 'init-org)
