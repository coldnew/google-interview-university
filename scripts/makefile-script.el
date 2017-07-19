;;; makefile-script.el --- Building script for this doc

;; Copyright (c) 2017 Yen-Chin, Lee.
;;
;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:
;;
;; This file is desinged to used by Makefile.


;;; Bootstrap

(require 'package)                      ; built-in
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; For important compatibility libraries like cl-lib
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))

;; This must come before configurations of installed packages.
;; Don't delete this line. If you don't want it, just comment it out by adding a
;; semicolon to the start of the line. You may delete these explanatory
;; comments.
(package-initialize)

;; Auto refresh packages info when no archive available.
(when (not package-archive-contents)
  (package-refresh-contents))

;; Install use-package
(package-install 'use-package)              ; Installed by packages.el

;; Code:
(require 'use-package)

;; Global config
(use-package org
  :ensure t
  :config
  ;; syntax highlight
  (use-package htmlize :ensure t)
  (setq org-html-htmlize-output-type 'css)
  ;; org-babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (clojure . t)
     (sh . t)
     (ditaa . t)
     (dot . t)
     (plantuml . t)))
  )

(defun generate-this-doc ()
  "Export the index.org to index.html."
  (find-file "index.org")
  (org-html-export-to-html))
