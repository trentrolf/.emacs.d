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
   ["#252525" "#ed4a46" "#70b433" "#dbb32d" "#368aeb" "#eb6eb7" "#3fc5b7" "#181818"])
 '(auto-revert-remote-files t)
 '(confirm-kill-emacs 'yes-or-no-p)
 '(custom-safe-themes
   '("830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36" "3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "524fa911b70d6b94d71585c9f0c5966fe85fb3a9ddd635362bfabd1a7981a307" default))
 '(ediff-diff-options "-w")
 '(ediff-split-window-function 'split-window-horizontally)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(yaml-mode solarized-theme cmake-mode vterm meson-mode bbcode-mode bitbake clang-format auto-complete auctex intel-hex-mode markdown-mode ag magit json-mode))
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'solarized-selenized-black t)
(setq mac-command-modifier 'control) ;; Use ctrl instead of cmd on Mac
(set-face-attribute 'default nil :height 160) ;; 160 == font size 16
