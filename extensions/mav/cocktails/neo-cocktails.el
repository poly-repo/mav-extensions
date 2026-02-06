;;; -*- lexical-binding: t -*-

;;; This is cocktails, a NEO extension
;;;
;;; Management of cocktail infrastructure

(require 'org)
(require 'org-id)

(neo/use-package tempel)

;(require 'tempel)
(defvar tempel-paths '())
(defvar tempel-template-sources '())

(with-eval-after-load 'tempel
  (add-to-list 'tempel-template-sources 'tempel-file)
  (add-to-list 'tempel-paths
               "/home/mav/.local/share/wtrees/mav-263-rework-side-window-management/devex/editors/emacs/"))


(defun neo/cocktail-new-recipe ()
  "Insert a new cocktail recipe Org subtree using Tempel."
  (interactive)
  (unless (derived-mode-p 'org-mode)
    (user-error "Not in Org mode"))
  ;; Optional: ensure we're at top-level
  (unless (org-at-heading-p)
    (goto-char (point-max))
    (unless (bolp) (insert "\n")))
  (tempel-insert 'org-cocktail-recipe))

(defun neo/org--collect-id-headings (&optional files)
  "Return alist of (DISPLAY . ID) from Org FILES."
  (let ((files (or files (org-agenda-files)))
        results)
    (dolist (file files)
      (with-current-buffer (find-file-noselect file)
        (org-with-wide-buffer
         (org-map-entries
          (lambda ()
            (when-let ((id (org-entry-get nil "ID"))
                       (title (org-get-heading t t t t)))
              (push (cons title id) results)))))))
    (nreverse results)))

(defun neo/org-insert-id-link (candidates &optional label)
  "Prompt for an ID from CANDIDATES and insert an Org id: link."
  (let* ((choice (completing-read
                  (or label "Select: ")
                  candidates nil t))
         (id (cdr (assoc choice candidates))))
    (insert (format "[[id:%s][%s]]" id choice))))

(defvar neo/cocktail-reference-files
  '("~/org/cocktails/cocktail-ice.org"
    "~/org/cocktails/cocktail-glassware.org"
    "~/org/cocktails/cocktail-method.org"))

(defun neo/cocktail--candidates ()
  (neo/org--collect-id-headings neo/cocktail-reference-files))

(defun neo/cocktail-insert-ice ()
  (interactive)
  (neo/org-insert-id-link
   (neo/cocktail--candidates)
   "Ice: "))

(defun neo/cocktail-insert-glass ()
  (interactive)
  (neo/org-insert-id-link
   (neo/cocktail--candidates)
   "Glass: "))

(defun neo/cocktail-insert-method ()
  (interactive)
  (neo/org-insert-id-link
   (neo/cocktail--candidates)
   "Method: "))

;;; Note, no (provide 'neo-cocktails) here, extensions are loaded not required.
