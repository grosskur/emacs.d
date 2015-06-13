;;; .emacs --- Alan's emacs configuration
;;;
;;; Commentary:
;;; Most of this just sets up packages from MELPA.
;;;
;;; Code:

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(setq inhibit-default-init t)

(menu-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-font-lock-mode 1)
(show-paren-mode)
(display-time)
(prefer-coding-system 'utf-8)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq-default indent-tabs-mode nil)
(setq-default mode-require-final-newline nil)
;(setq-default require-final-newline nil)
;(setq-default scroll-up-aggressively 0.01)
;(setq-default scroll-down-aggressively 0.01)

(setq blink-cursor-mode 0)
(setq column-number-mode t)
(setq compilation-ask-about-save nil)
(setq compilation-read-command nil)
(setq compilation-window-height 15)
(setq default-major-mode 'text-mode)
(setq default-tab-width 4)
(setq fill-column 76)
(setq font-lock-maximum-decoration t)
(setq inhibit-startup-message t)
(setq line-number-mode t)
(setq make-backup-files nil)
(setq mouse-yank-at-point nil)
(setq next-line-add-newlines nil)
(setq query-replace-highlight t)
;(setq scroll-margin 1)
;(setq scroll-conservatively 0)
(setq scroll-conservatively 9999)
(setq scroll-preserve-screen-position t)
(setq scroll-step 1)
(setq search-highlight t)
(setq temporary-file-directory "~/.emacs.d/tmp/")
(setq transient-mark-mode t)
(setq x-select-enable-clipboard t)
(setq x-stretch-cursor t)

(defalias 'qrr 'query-replace-regexp)

; MELPA configuration

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

; MELPA packages

(add-hook 'after-init-hook #'global-flycheck-mode)

; regular packages

;(load "~/.emacs.d/site-lisp/load-path.el")
;(add-to-list 'load-path "~/.emacs.d/site-lisp")

;(require 'flymake-csslint)
;(require 'flymake-cursor)
;(require 'flymake-jshint)
;(require 'flymake-less)
;(require 'flymake-shell)
;(require 'show-wspace)

(require 'ethan-wspace)
(require 'flycheck)
(require 'go-mode-autoloads)
(require 'nginx-mode)
(require 'puppet-mode)
(require 'yaml-mode)

;(global-ethan-wspace-mode 1)

(autoload 'dockerfile-mode "dockerfile-mode" "Mode for editing Dockerfiles" t)
(autoload 'django-mode "django-mode" "Mode for editing Django templates" t)
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(autoload 'muttrc-mode "muttrc-mode" "Mode for editing muttrc files" t)
(autoload 'xrdb-mode "xrdb-mode" "Mode for editing X resource files" t)

(add-to-list 'auto-mode-alist '("Cask$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml$" . django-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode))
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'auto-mode-alist '("\\.mutt/.*$" . muttrc-mode))
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
(add-to-list 'auto-mode-alist '("\\.xresources$" . xrdb-mode))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("Dockerfile$" . dockerfile-mode))

(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(add-hook 'js2-mode-hook 'flycheck-mode)

(add-hook 'lua-mode-hook
          '(lambda ()
             (setq lua-indent-level 2)))

;(add-hook 'css-mode-hook 'flymake-mode)
;(add-hook 'less-css-mode-hook 'flymake-less-load)
;(add-hook 'js-mode-hook 'flymake-mode)
;(add-hook 'sh-set-shell-hook 'flymake-shell-load)
(add-hook 'text-mode-hook 'text-mode-hook-identify)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(add-hook 'python-mode-hook
          '(lambda ()
             (set-variable 'py-python-command "python")
             (set-variable 'py-default-interpreter 'cpython)
             (set-variable 'py-indent-offset 4)
             (set-variable 'py-continuation-offset 4)
             (set-variable 'py-smart-indentation nil)
             (set-variable 'indent-tabs-mode nil)
             (outline-minor-mode)
             (setq outline-regexp " *\\(def \\|clas\\|#hea\\)")))

(add-hook 'go-mode-hook
          '(lambda ()
             (setq gofmt-command "goimports")
             (setq flycheck-go-vet-print-functions "")
             (add-hook 'before-save-hook 'gofmt-before-save)))

;(eval-after-load "go-mode"
;  '(require 'flymake-go))

(add-hook 'sh-mode-hook
          '(lambda ()
             (setq sh-basic-offset 2
                   sh-indentation 2)))

(add-hook 'web-mode-hook
          '(lambda ()
             (setq web-mode-markup-indent-offset 2)))

(flycheck-define-checker javascript-flow
    "A JavaScript syntax and style checker using Flow.

See URL `http://flowtype.org/'."
    :command ("flow" source-original)
    :error-patterns
    ((error line-start
            (file-name)
            ":"
            line
            ":"
            (minimal-match (one-or-more not-newline))
            ": "
            (message (minimal-match (and (one-or-more anything) "\n")))
            line-end))
      :modes js-mode)

;(add-to-list 'flycheck-checkers 'javascript-flow 'append)
(flycheck-add-next-checker 'javascript-jshint 'javascript-flow)

(provide 'init)
;;; init.el ends here
