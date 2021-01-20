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
 '(custom-enabled-themes (quote (deeper-blue)))
 '(ediff-diff-options "-w")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(helm-completion-style (quote emacs))
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(org-export-backends (quote (ascii html icalendar latex md odt confluence)))
 '(package-selected-packages
   (quote
    (ess julia-repl julia-mode yaml-mode htmlize auctex todoist counsel helm ztree intel-hex-mode org elpy markdown-mode ag magit json-mode go-mode)))
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
(setq org-directory "~/Dropbox/org")

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

(setenv "VAULT_USER" "vuemb")
(setenv "VAULT_PASSWORD" "^3zs1U1Pi&TxJW13nAKTy!kr3M!nF5QOG")
(setenv "GITHUB_TOKEN" "8e1f4327233ac07796a759009d6854351441a724")

(setenv "PATH" (concat (getenv "PATH") ":/home/trolf/hotdrop/external/firmware_common/tools/vutiliti_packet_tool/_build"))
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/go/bin"))
(setenv "PATH" (concat (getenv "PATH") ":/home/trolf/go/bin"))

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

(setq initial-buffer-choice "~")

;; Save history for minibuffer and eshell
(savehist-mode 1)

(require 'helm-eshell)
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map (kbd "C-r")  'helm-eshell-history)))
