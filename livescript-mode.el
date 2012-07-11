;;; livescript-mode.el --- Major mode for LiveScript files in Emacs

;; Copyright (C) 2011 Mikhail Kuryshev

;; Version: 0.0.1
;; Author: Mikhail Kuryshev <tensai@cirno.in>
;; Keywords: languages

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.(require 'easymenu)

;;; Code:

(eval-when-compile
  (require 'cl))

;; Variables

(defconst livescript-mode-version "0.0.1"
  "The version of `livescript-mode'.")

(defgroup livescript nil
  "A LiveScript major mode."
  :group 'languages)

(defcustom livescript-command "livescript"
  "The LiveScript command used for evaluating code."
  :type 'string
  :group 'livescript)

(defcustom livescript-args-compile '("-c")
  "The arguments to pass to `livescript-command' to compile a file."
  :type 'list
  :group 'livescript)

(defcustom livescript-compiled-buffer-name "*livescript-compiled*"
  "The name of the scratch buffer used for compiled LiveScript"
  :type 'string
  :group 'livescript)

(defvar livescript-mode-map (make-keymap)
  "Keymap for LiveScript major mode.")

;; Functions

(defun livescript-compile-buffer ()
  "Compiles the current buffer and displays the JavaScript in a buffer
called `livescript-compiled-buffer-name'."
  (interactive)
  (save-excursion
    (livescript-compile-region (point-min) (point-max))))

(defun livescript-compile-region (start end)
  "Compiles a region and displays the JavaScript in a buffer called
`livescript-compiled-buffer-name'."
  (interactive "r")

  (let ((buffer (get-buffer livescript-compiled-buffer-name)))
    (when buffer
      (kill-buffer buffer)))

  (apply (apply-partially 'call-process-region start end livescript-command nil
                          (get-buffer-create livescript-compiled-buffer-name)
                          nil)
         (append livescript-args-compile (list "-s" "-p")))
  (switch-to-buffer (get-buffer livescript-compiled-buffer-name))
  (let ((buffer-file-name "_tmp.js")) (set-auto-mode))
  (goto-char (point-min)))

;; Menubar

(easy-menu-define livescript-mode-menu livescript-mode-map
  "Menu for LiveScript mode"
  '("LiveScript"
    ["Compile Buffer" livescript-compile-buffer]
    ))

;; Define major mode

(define-derived-mode livescript-mode fundamental-mode
  "LiveScript"
  "Major mode for editing LiveScript."

  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq indent-line-function 'insert-tab))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ls$" . livescript-mode))

;; Setup
(provide 'livescript-mode)
;;; livescript-mode.el ends here
