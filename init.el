(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
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
 '(custom-enabled-themes (quote (tango-dark)))
 '(ediff-diff-options "-w")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(helm-completion-style (quote emacs))
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(org-agenda-files (quote ("~/Dropbox/todo.org")))
 '(org-export-backends (quote (ascii html icalendar latex md odt confluence)))
 '(package-selected-packages
   (quote
    (htmlize auctex todoist counsel helm ztree intel-hex-mode org elpy markdown-mode ag magit json-mode go-mode)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq-default tab-width 4)

(setq-default truncate-lines 1)

(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
                                        comment-end   "")))

;; org settings
(add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(global-set-key (kbd "C-c a") 'org-agenda)
(find-file "~/Dropbox/todo.org")        ;Open todo.org so it's in buffer list
(org-agenda nil "a")                    ;Open agenda view.

(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

(global-set-key (kbd "C-;") 'ag-project)
(global-set-key (kbd "C-x m") 'magit-status)

(elpy-enable)
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")
(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(push (substitute-in-file-name "path-to-ztree-directory") load-path)
(require 'ztree)

(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))

; Trying to get gdb remote working.
;(setq exec-path (append exec-path '("/usr/local/gcc-arm-none-eabi-7-2018-q2-update/bin")))

(defun ansi-term-name (new-name)
  "Start ansi-term and rename it."
  (ansi-term "/bin/bash")
  (rename-buffer new-name t))

(defun segger-debug ()
  (interactive)
  (ansi-term-name "rtt")
  (ansi-term-name "jlink"))

(setq c-default-style "stroustrup")

(put 'magit-clean 'disabled nil)

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)
