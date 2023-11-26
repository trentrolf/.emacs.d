(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(auto-revert-remote-files t)
 '(confirm-kill-emacs 'yes-or-no-p)
 '(ediff-diff-options "-w")
 '(ediff-split-window-function 'split-window-horizontally)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(cmake-mode vterm meson-mode bbcode-mode bitbake clang-format auto-complete auctex intel-hex-mode markdown-mode ag magit json-mode))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(split-width-threshold 300)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

(setq-default tab-width 4)

(setq-default truncate-lines 1)

(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
                                        comment-end   "")))

(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

(global-set-key (kbd "C-;") 'ag)
(global-set-key (kbd "C-x m") 'magit-status)
(global-set-key (kbd "M-/") 'xref-find-references)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq c-default-style "stroustrup")

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)

;; Save history for minibuffer and eshell
(savehist-mode 1)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(global-set-key (kbd "C-,") 'ido-switch-buffer)

(defun ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapcar (lambda (x)
              (push (prin1-to-string x t) tag-names))
            tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))

(global-set-key (kbd "C-'") 'ido-find-tag)

(setq auto-mode-alist (cons '("\\.bb$" . bitbake-mode) auto-mode-alist))

(defun vtn ()
  "Ask for a name and create a new vterm shell."
  (interactive)
  (vterm (read-string "Name for this vterm: ")))

;; No bell
(setq ring-bell-function 'ignore)

;; Don't log when auto-reverting buffers
(setq auto-revert-verbose nil)
