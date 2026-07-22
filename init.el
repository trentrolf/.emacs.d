(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-;") 'ag)
(global-set-key (kbd "C-x m") 'magit-status)
(global-set-key (kbd "M-/") 'xref-find-references)
(global-set-key (kbd "C-x C-g") 'fzf-git-files)
(global-set-key (kbd "C-x b") 'fzf-switch-buffer)

(menu-bar-mode -1)
(when (display-graphic-p)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (pixel-scroll-precision-mode 1)) ;; smooth pixel-based scrolling in the GUI

(setq auto-revert-remote-files t)
(setq confirm-kill-emacs 'yes-or-no-p)
(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(show-paren-mode 1)
;; 1) First try to show buffers in *some* existing window (other than the
;;    one you’re in), then fall back to re-using a window showing the same
;;    buffer, and *only* if neither of those work do we split.
(setq display-buffer-alist
      '((".*"   ;; applies to every buffer
         . ((display-buffer-use-some-window
             display-buffer-reuse-window
             display-buffer-pop-up-window)
            (inhibit-same-window . t)))))

;; 2) And just to make sure splitting still goes side-by-side, but only
;;    when you really need a split:
(setq split-height-threshold nil
      split-width-threshold 160)
(setq tab-width 4)
(setq c-default-style "stroustrup")
(setq-default indent-tabs-mode nil)
(savehist-mode 1) ;; Save history for minibuffer and eshell
(setq ring-bell-function 'ignore) ;; No bell
(setq auto-revert-verbose nil) ;; Don't log when auto-reverting buffers
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'control)) ;; Use ctrl instead of cmd on Mac
(set-default 'truncate-lines t)
(add-to-list 'auto-mode-alist '("\\.bb\\'" . bitbake-mode))
(setq magit-diff-refine-hunk 'all) ;; set word-level diff in magit diffs

(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
                                        comment-end   "")))

;; Wrap long lines in plain text and Markdown buffers.
;; markdown-mode derives from text-mode, so this covers both.
(add-hook 'text-mode-hook 'visual-line-mode)

(add-hook 'prog-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'delete-trailing-whitespace nil t)))

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)

(load-theme 'modus-vivendi t)
(when (display-graphic-p)
  (set-face-attribute 'default nil
                      :family (if (eq system-type 'darwin) "Monaco" "DejaVu Sans Mono")
                      :height 120)
(setq mac-option-modifier 'meta))

(defun vtn ()
  "Ask for a name and create a new vterm shell."
  (interactive)
  (vterm (read-string "Name for this vterm: ")))

;; Automatically use the right TAGS file based on which repo a file lives in,
;; instead of running M-x visit-tags-table by hand each session.
(setq tags-revert-without-query t) ;; Reload TAGS silently after regenerating
(defvar my-tags-alist
  '(("~/data/pdsw-sonos-controller-player-s2/" . "~/data/trent-utils/etags/player/TAGS")
    ("~/data/chirp-c-sdk/"                     . "~/data/trent-utils/etags/chirp-noise/TAGS")
    ("~/data/chirp-noise/"                     . "~/data/trent-utils/etags/chirp-noise/TAGS")
    ("~/data/py-sonos-test-core/"              . "~/data/trent-utils/etags/py-sonos-test-core/TAGS"))
  "Map repo prefix -> TAGS file.")
(defun my-set-tags-file ()
  (when buffer-file-name
    (dolist (entry my-tags-alist)
      (when (string-prefix-p (expand-file-name (car entry)) buffer-file-name)
        (setq-local tags-file-name (expand-file-name (cdr entry)))))))
(add-hook 'find-file-hook #'my-set-tags-file)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3613617b9953c22fe46ef2b593a2e5bc79ef3cc88770602e7e569bbd71de113b" "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098" "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(cmake-mode doom-themes ag bitbake fzf json-mode magit markdown-mode vterm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
