;;; path-match.el --- set the mode-line color based on file name or path

;; Copyright (C) 2010, 2011, 2012 Colin Marquardt

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;; 

;;; History:
;; 

;;; Code:

;; collect info a single time after loading this library:
(unless (boundp 'old-mode-line-background)
  (setq old-mode-line-background (face-background 'mode-line)))
;; NOTE: this doesn't work since mode-line-inactive
;;       inherits from mode-line which face-background doesn't resolve to a face name:
;(unless (boundp 'old-mode-line-background-inactive)
;  (setq old-mode-line-background-inactive (face-background 'mode-line-inactive)))
(unless (boundp 'old-mode-line-background-inactive)
  (setq old-mode-line-background-inactive (face-background 'mode-line)))

;;;###autoload
(defun cm-color-mode-line-filename-based ()
  "Set the mode-line color based on `buffer-file-name'."
  (interactive)
  ;; default:
  ;; set default mode-line face:
  (set-face-background 'mode-line          old-mode-line-background          (window-frame (frame-selected-window)))
  (set-face-background 'mode-line-inactive old-mode-line-background-inactive (window-frame (frame-selected-window)))
  (if buffer-file-name
      ;; color codes:
      ;; old: blue
      ;; medium: red
      ;; new: yellow
      (cond ((string-match "rev_demoplus" buffer-file-name)
             (set-face-background 'mode-line "#4488e8" (window-frame (frame-selected-window))))
            ((string-match "rev_a1"       buffer-file-name)
             (set-face-background 'mode-line "#a8e46c" (window-frame (frame-selected-window))))
            ((string-match "rev_work"     buffer-file-name)
             (set-face-background 'mode-line "goldenrod1" (window-frame (frame-selected-window))))
            )))

;; is this okay?
(add-hook 'post-command-hook 'cm-color-mode-line-filename-based)

(provide 'path-match)

;;; path-match.el ends here

;;; Notes:

;;;; from http://stackoverflow.com/questions/534307/set-emacs-defaut-font-face-per-buffer-mode
;;(defadvice switch-to-buffer (after switch-to-buffer activate compile)
;;  "Change the mode-line after switch-to-buffer."
;;  (cm-color-mode-line-filename-based))
;;
;;(defadvice other-window (after other-window activate compile)
;;  "Change the mode-line after other-window."
;;  (cm-color-mode-line-filename-based))
;;
;; also advice: kill-buffer

;; FIXME: better use buffer-face-mode?
