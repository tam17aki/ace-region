;;; ace-region.el --- A utility for region expansion by using ace-jump-mode -*- coding: utf-8; lexical-binding: t -*-

;; Copyright (C) 2014 by Akira TAMAMORI

;; Author: Akira Tamamori
;; URL: https://github.com/tam17aki/ace-region
;; Version: 0.01
;; Created: Jan 11 2015
;; Package-Requires: ((ace-jump-mode "2.0") (region-bindings-mode "1.4"))

;; This program is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation, either version 3 of the License, or (at your option) any later
;; version.

;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
;; details.

;; You should have received a copy of the GNU General Public License along with
;; this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Installation:
;;
;; To use this package, add following code to your init file.
;;
;; (require 'ace-region)
;; (global-ace-region-mode +1)

;;; Code:
(require 'ace-jump-mode)
(require 'region-bindings-mode)

(defgroup ace-region nil
  "Group of ace-region."
  :group 'convenience)

(defcustom ace-region-lighter " AceR"
  "Lighter of ace-region-mode."
  :type 'string
  :group 'ace-region)

(defcustom ace-region-jump-key "C-j" nil
  :type 'string
  :group 'ace-region)

(defun ace-region--forward-backward-char ()
  (when (region-active-p)
    (cond ((< (mark) (point))
           (forward-char))
          (t
           (backward-char)))))

(defun ace-region--jump-function ()
  (interactive)
  (exchange-point-and-mark)
  (let ((ace-jump-mode-scope 'window))
    (call-interactively 'ace-jump-char-mode)))

;;;###autoload
(define-minor-mode ace-region-mode
  "Minor-mode which provides some utilities for region expansion."
  :group      'ace-region
  :init-value nil
  :global     nil
  :lighter    ace-region-mode-lighter
  (cond (ace-region-mode
         (add-hook 'ace-jump-mode-end-hook #'ace-region--forward-backward-char nil t)
         (define-key region-bindings-mode-map
           (kbd ace-region-jump-key) #'ace-region--jump-function))
        (t
         (remove-hook 'ace-jump-mode-end-hook #'ace-region--forward-backward-char t)
         (define-key region-bindings-mode-map (kbd ace-region-jump-key) nil))))

(defun ace-region--turn-on ()
  (unless (minibufferp)
    (ace-region-mode +1)))

(define-globalized-minor-mode global-ace-region-mode ace-region-mode ace-region--turn-on
  :group 'ace-region)

(provide 'ace-region)
;;; ace-region.el ends here
