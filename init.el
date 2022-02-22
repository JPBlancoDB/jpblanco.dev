;;; build.el --- Minimal emacs installation to build the website -*- lexical-binding: t -*-
;; Based on the one from Bruno Henriques: https://github.com/bphenriques/knowledge-base/blob/master/tools/init.el
;;
;;; Commentary:
;;
;;; Code:

(require 'subr-x)

(toggle-debug-on-error)      ;; Show debug informaton as soon as error occurs.
(setq make-backup-files nil) ;; Disable "<file>~" backups.

;; Setup packages using straight.el: https://github.com/raxod502/straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

(use-package backtrace)
(use-package ox-hugo
  :straight (:type git :host github :repo "kaushalmodi/ox-hugo"))

;;; Public functions
(defun build/export-all ()
  "Export all org-files (including nested)."

  (setq
    org-hugo-base-dir (file-name-directory buffer-file-name)
    org-hugo-section "posts")

  (dolist (org-file (directory-files-recursively (file-name-directory buffer-file-name) "\.org$"))
    (with-current-buffer (find-file org-file)
      (message (format "[build] Exporting %s" org-file))
      (org-hugo-export-wim-to-md :all-subtrees nil nil nil)))

  (message "Done!"))

(provide 'build/export-all)

;;; init.el ends here
