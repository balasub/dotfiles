;; Make the load command always prefer the newest version of a file.
(setq load-prefer-newer t)

;; Minimize garbage collection during startup.
(setq gc-cons-threshold most-positive-fixnum
      message-log-max 1024)

;; Workaround for melpa over https.
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(defvar daniel-root-dir
  "~/.emacs.d/"
  "The root dir of the Emacs configuration.")

;; Do not put custom configuration in init.el
(setq custom-file (concat daniel-root-dir "custom-file.el"))

(defvar daniel-modules-dir
  (expand-file-name "modules/" daniel-root-dir)
  "Directory containingi configuration modules.")

(add-to-list 'load-path daniel-modules-dir)

;; Load our custom-file.el.
(load custom-file)

;; No menu bar
(menu-bar-mode -1)

;; No tool bar
(tool-bar-mode -1)

;; Highlight the current line
(global-hl-line-mode t)

;; Display line numbers
(line-number-mode t)

;; Inhibit startup and scratch buffer messages
(setq inhibit-startup-message t
      initial-scratch-message nil)

;; Put all backup files in a single location
(setq backup-directory-alist `(("." . "~/.saves")))

;; Set up package
(require 'package)

;; Add melpa to package archives
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Load packages
(package-initialize)

;; Install 'use-package' if it is not installed.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Helm
(require 'helm)
(helm-mode 1)

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

(use-package ewal-spacemacs-themes
  :ensure t
  :config
  (load-theme 'spacemacs-dark t))

(use-package tree-sitter-langs
  :defer 3
  :ensure t
  :demand
  :config
  (setq tree-sitter-load-path `(,(expand-file-name "~/.tree-sitter/bin"))))

(load "formula.el")

(add-hook 'formula-mode-hook
          (lambda ()
            (formula-tree-sitter-setup)
            (font-lock-fontify-buffer)))

(use-package tree-sitter
  :ensure t
  :demand
  :diminish "ts"
  :hook (tree-sitter-after-on . tree-sitter-hl-mode)
  :config
  (setq tree-sitter-load-path `(,(expand-file-name "~/.tree-sitter/bin")))
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (setq tree-sitter-major-mode-language-alist
        `((formula-mode . formula)
          ,@tree-sitter-major-mode-language-alist)))

;; Setup and use gcmh-mode for improved garbage collection.
(use-package gcmh
  :ensure t
  :demand
  :hook
  (focus-out-hook . gcmh-idle-garbage-collect)

  :custom
  (gcmh-idle-delay 10)
  (gcmh-high-cons-threshold 104857600)

  :config
  (gcmh-mode +1))
