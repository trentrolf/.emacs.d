(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
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
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

(setq auto-revert-remote-files t)
(setq confirm-kill-emacs 'yes-or-no-p)
(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(setq show-paren-mode t)
(setq split-width-threshold 300)
(setq tab-width 4)
(setq c-default-style "stroustrup")
(setq indent-tabs-mode nil)
(setq savehist-mode t) ;; Save history for minibuffer and eshell
(setq ring-bell-function 'ignore) ;; No bell
(setq auto-revert-verbose nil) ;; Don't log when auto-reverting buffers
(setq mac-command-modifier 'control) ;; Use ctrl instead of cmd on Mac
;; (setq todoist-token "b07ee591020a6004c182a5790a0290681c5839f5")
(set-default 'truncate-lines t)
(setq auto-mode-alist (cons '("\\.bb$" . bitbake-mode) auto-mode-alist))

(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
                                        comment-end   "")))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)

(load-theme 'tango-dark t)
(set-face-attribute 'default nil :height 140) ;; 160 == font size 16

(defun vtn ()
  "Ask for a name and create a new vterm shell."
  (interactive)
  (vterm (read-string "Name for this vterm: ")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary nil)
 '(package-selected-packages '(vterm fzf markdown-mode bitbake json-mode ag magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
