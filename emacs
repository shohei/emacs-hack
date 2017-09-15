
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  )

(require 'request)

(setq ring-bell-function #'ignore) (setq scroll-conservatively 10000)
(setq inhibit-startup-message t)
(global-linum-mode t)

(setq exec-path (cons "/usr/local/bin" exec-path))
(setenv "PATH"
	(concat '"/usr/local/bin:" (getenv "PATH")))

;; [Facultative] Only if you have installed async.
(add-to-list 'load-path "/Users/shohei/Documents/helm/async")
(add-to-list 'load-path "/Users/shohei/Documents/helm")
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-autoresize-mode 1)
(setq helm-autoresize-max-height 25)

(require 'whitespace)
(set-face-foreground 'whitespace-space "DarkGoldenrod1")
(set-face-background 'whitespace-space nil)
(set-face-bold-p 'whitespace-space t)
(set-face-foreground 'whitespace-tab "DarkOliveGreen1")
(set-face-background 'whitespace-tab nil)
(set-face-underline  'whitespace-tab t)
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(global-whitespace-mode 1) ; 全角スペースを常に表示
(global-set-key (kbd "C-x w") 'global-whitespace-mode) ; 全角スペース表示の切替

(add-to-list 'load-path "~/.emacs.d/vendor/arduino-mode")
(require 'arduino-mode)
;(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
;(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

;;; emacsclient
(load "server")
(unless (server-running-p) (server-start))
;;  C-x C-cに割り当てる
(global-set-key (kbd "C-x C-c") 'server-edit)
;; M-x exitでEmacsを終了できるようにする
(defalias 'exit 'save-buffers-kill-emacs)

;For transparency
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))
;; (set-face-attribute 'default nil :background "black"
;;   :foreground "gray" :font "Ricty Diminished" :height 180)

;save your pinky!
;(global-set-key "\M-n" "\C-n")
;(global-set-key "\M-p" "\C-p")

(set-face-attribute 'default nil
 :family "Ricty Diminished" ;; font 
 :height 140) ;; font size

(tool-bar-mode -1)

;; language settings
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
;(setq mac-option-modifier nil
;  mac-command-modifier 'meta)
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
;(pdf-tools-install)

; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
; (load-theme 'dark-laptop t t)
;(require 'monokai-theme)
;(load-theme 'monokai t)
(require 'railscasts-theme)
(load-theme 'railscasts t nil)

;(load-theme 'wombat t)
; (require 'hc-zenburn-theme)
; (load-theme 'hc-zenburn t)
;(load-theme 'manoj-dark t)

;; Gauche用の設定
;; 対応する括弧を表示する
(show-paren-mode t)
;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;; .#* とかのバックアップファイルを作らない 
(setq auto-save-default nil)
;; ^H を バックスペースへ
(global-set-key "\C-h" 'delete-backward-char)
;; 括弧の補完
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)
;; emacsでGauche
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
(setq scheme-program-name "/usr/local/bin/gosh -i")

(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

(defun scheme-other-window ()
  "Run Gauche on other window"
  (interactive)
  (split-window-horizontally (/ (frame-width) 2))
  (let ((buf-name (buffer-name (current-buffer))))
    (scheme-mode)
    (switch-to-buffer-other-window
     (get-buffer-create "*scheme*"))
    (run-scheme scheme-program-name)
    (switch-to-buffer-other-window
     (get-buffer-create buf-name))))

(define-key global-map
  "\C-cG" 'scheme-other-window)

(require 'zlc)
(zlc-mode t)


;; -Powerlinee
(require 'powerline)
(powerline-default-theme)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("64581032564feda2b5f2cf389018b4b9906d98293d84d84142d90d7986032d33" default)))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (shell-pop w3m igrep migemo recentf-ext elixir-mode plantuml-mode ace-window dired-details dired-subtree auto-install zlc zenburn-theme yascroll yaml-mode web-mode volatile-highlights undohist swift-mode solarized-theme smooth-scroll smex smartparens smart-compile slime sequential-command scala-mode2 request rainbow-delimiters railscasts-theme projectile powerline point-undo php-mode pdf-tools paredit monokai-theme markdown-mode magit js2-mode inf-ruby ido-ubiquitous hlinum helm hc-zenburn-theme haskell-mode gitconfig-mode git-gutter-fringe git gist flycheck expand-region exec-path-from-shell evil elisp-slime-nav dired+ diminish ctable color-theme clojure-mode-extra-font-locking cider auto-complete anzu ace-jump-mode)))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 587))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'ruby-mode)
(require 'smart-compile)
(define-key ruby-mode-map (kbd "C-c c") 'smart-compile) 
(define-key ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))

(add-to-list 'load-path "~/.emacs.d/vendor/gist.el")
(require 'gist)

(define-key global-map (kbd "s-n")
  (lambda () (interactive) (progn
     (switch-to-buffer "*scratch*"))))
(define-key global-map (kbd "s-s") 'save-buffer)
(define-key global-map (kbd "s-z") 'undo)
(define-key global-map (kbd "s-w") 'delete-frame)
(define-key global-map (kbd "s-v") 'yank)
(define-key global-map (kbd "s-c") 'copy-region-as-kill)
(define-key global-map (kbd "s-x") 'kill-region) 
(define-key global-map (kbd "s-/") 'hippie-expand)
;(define-key global-map (kbd "s-q") 'kill-emacs)

(add-to-list 'default-frame-alist '(background-color . "#333333"))
(set-face-foreground 'font-lock-comment-face "#999999")

(setq initial-scratch-message nil)

(scroll-bar-mode 0)

(setq frame-title-format "emacs")

;; コマンドキーはコマンドキー（Super）として使うことにする。メタキーはオルト。
;; (when (eq system-type 'darwin)
;;   (setq ns-command-modifier (quote meta)))

(require 'sequential-command-config)
(sequential-command-setup-keys)

(global-set-key (kbd "C-;") 'set-mark-command) 

;; そろそろEmacsのウィンドウについて一言いっとくか
;; http://d.hatena.ne.jp/rubikitch/20100210/emacs        
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "C-t") 'other-window-or-split)
;;  Dired用にウィンドウ切り替え設定
(add-hook 'dired-mode-hook
  (lambda ()
    (define-key dired-mode-map (kbd "C-t") 'other-window-or-split)
    (local-unset-key (kbd "C-t"))
    ))
;;他のバッファを全て削除
(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer 
          (delq (current-buffer) 
                (remove-if-not 'buffer-file-name (buffer-list)))))
;;デバッグエラー詳細表示
(setq debug-on-error t)

;; (require 'key-chord)
;; (setq key-chord-two-keys-delay 0.01)
;; (key-chord-mode 1)
;; (key-chord-define-global "jk" 'view-mode)
;; (key-chord-define emacs-lisp-mode-map "df" 'describe-function)

(require 'elixir-mode)

(ffap-bindings)

(require 'uniquify)
(setq uniquify-buffer-name-stype 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

(iswitchb-mode 1)
(setq read-buffer-function 'iswitchb-read-buffer)
(setq iswitchb-regexp nil)
(setq iswitchb-prompt-newbuffer nil)

(ido-mode 1)
(ido-everywhere 1)

(setq recentf-max-saved-items 3000)
(setq recentf-exclude '("/TAGS$","/var/tmp/"))
(require 'recentf-ext)

(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(setq bookmark-save-flag 1)
(progn
  (setq bookmark-sort-flag nil)
  (defun bookmark-arrange-latest-top ()
    (let ((latest (bookmark-get-bookmark bookmark)))
      (setq bookmark-alist (cons latest (delq latest bookmark-alist))))
    (bookmark-save))
  (add-hook 'bookmark-after-jump-hook 'bookmark-arrange-latest-top))

(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

(require 'migemo)
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-user-dictionary nil)
(setq migemo-coding-system 'utf-8)
(setq migemo-regex-dictionary nil)
(load-library "migemo")
(migemo-init)

(require 'point-undo)
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-redo)

(setq-default bm-buffer-persistence nil)
(setq bm-restore-repository-on-load t)
(require 'bm)
(add-hook 'find-file-hooks 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)
(global-set-key (kbd "M-SPC") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)


(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))

(require 'igrep)
(igrep-define lgrep (igrep-use-zgrep nil)(igrep-regex-option "-n -Ou8"))
(igrep-find-define lgrep (igrep-use-zgrep nil)(igrep-regex-option "-n -Ou8"))

;; エスケープシーケンスによる色が付くようになる
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; パスワードのプロンプトを認識し、入力時はミニバッファで伏せ字になる。
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

(require 'shell-pop)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(shell-pop-shell-type (quote ("ansi-term" "*shell-pop-ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
 '(shell-pop-term-shell "/bin/zsh")
 '(shell-pop-universal-key "C-M-t")
 '(shell-pop-window-height 20)
 '(shell-pop-window-position "bottom"))

(require 'shell-history)

(require 'multi-term)
;;; 快適に使うためには、以下の2変数を調整する必要がある。
;; C-x C-c ESCは端末に渡さないでEmacsが使うようにする。
(setq term-unbind-key-list '("C-x" "C-c" "<ESC>")) ;; 以下のコマンドを使えるようにする。
(setq term-bind-key-alist
      '(("C-c C-c" . term-interrupt-subjob)
	("C-m" . term-send-raw)
	("M-f" . term-send-forward-word)
	("M-b" . term-send-backward-word)
	("M-o" . ternm-send-backspace)
	("M-p" . term-send-up)
	("M-n" . term-send-down)
	("M-M" . term-send-forward-kill-word)
	("M-N" . term-send-backward-kill-word)
	("M-r" . term-send-reverse-search-history)
	("M-," . term-send-input)
	("M-." . comint-dynamic-complete)))


