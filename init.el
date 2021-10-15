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
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("c1284dd4c650d6d74cfaf0106b8ae42270cab6c58f78efc5b7c825b6a4580417" "549ccbd11c125a4e671a1e8d3609063a91228e918ffb269e57bd2cd2c0a6f1c6" default)))
 '(ediff-diff-options "-w")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (auto-complete dracula-theme ess julia-repl julia-mode auctex ztree intel-hex-mode markdown-mode ag magit json-mode go-mode)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "DAMA" :slant normal :weight normal :height 143 :width normal)))))

(setq-default tab-width 4)

(setq-default truncate-lines 1)

(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
                                        comment-end   "")))

(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

(global-set-key (kbd "C-;") 'ag-project)
(global-set-key (kbd "C-x m") 'magit-status)
(global-set-key (kbd "C-o") 'other-window)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(push (substitute-in-file-name "path-to-ztree-directory") load-path)
(require 'ztree)

(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))

;; (setenv "VAULT_USER" "vuemb")
;; (setenv "VAULT_PASSWORD" "^3zs1U1Pi&TxJW13nAKTy!kr3M!nF5QOG")
;; (setenv "GITHUB_TOKEN" "8e1f4327233ac07796a759009d6854351441a724")

;; (setenv "PATH" (concat (getenv "PATH") ":/home/trolf/hotdrop/external/firmware_common/tools/vutiliti_packet_tool/_build"))
;; (setenv "PATH" (concat (getenv "PATH") ":/usr/local/go/bin"))
;; (setenv "PATH" (concat (getenv "PATH") ":/home/trolf/go/bin"))

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

;; Save history for minibuffer and eshell
(savehist-mode 1)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(global-set-key (kbd "C-m") 'ido-switch-buffer)

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

(global-auto-complete-mode t)
