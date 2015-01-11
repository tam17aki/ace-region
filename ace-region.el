;;; ace-region.el --- A utility for region expansion by using ace-jump-mode -*- coding: utf-8; lexical-binding: t -*-

;; Copyright (C) 2014 by Akira TAMAMORI

;; Author: Akira Tamamori
;; URL: https://github.com/tam17aki/ace-region
;; Version: 0.01
;; Created: Jan 11 2015
;; Package-Requires: ((ace-jump-mode "2.0") (region-bindings-mode "1.4") (emacs "24"))

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
;; (require 'ace-region)

;;; Code:
(require 'ace-jump-mode)
(require 'region-bindings-mode)

(define-key region-bindings-mode-map (kbd "C-j")
  #'(lambda ()
      (interactive)
      (exchange-point-and-mark)
      (let ((ace-jump-mode-scope 'window))
        (call-interactively 'ace-jump-char-mode))))

(provide 'ace-region)
;;; ace-region.el ends here
