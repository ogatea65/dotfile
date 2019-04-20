;;;;;;;;;;;;;;;;; 基本設定 START;;;;;;;;;;;;;;;;;
;; 日本語IM用の設定
(setq default-input-method "MacOSX")

; 言語を日本語にする（UTF-8）
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;; 警告音もフラッシュも全て無効
(setq ring-bell-function 'ignore)

; ロードパス
;; load-pathを追加する関数を定義
(setq user-emacs-directory "~/.emacs.d/")
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory(expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))
;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "conf" "elisp" "elpa" "etc" "info" "public_repos")

;; コマンドにパスを通す
(add-to-list 'exec-path "/usr/local/bin")
;;;;;;;;;;;;;;;;; 基本設定 END;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; パッケージ管理設定 START;;;;;;;;;;;;;;;;;
;; package.el
(require 'package)

;; melpa.el
(require 'melpa)


; Add package-archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
; Initialize
(package-initialize)

;;auto-install
(add-to-load-path "auto-install")
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-compatibility-setup)
;;;;;;;;;;;;;;;;; パッケージ管理設定 END;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;ウィンドウ管理 START;;;;;;;;;;;;;;;;;
;; elscreen
;; APEL非依存版 (Emacs 24の場合)
(when (>= emacs-major-version 24)
	  (elscreen-start))

(elscreen-set-prefix-key "\C-t")
;(load "elscreen" "ElScreen" t)
;; タブを表示(非表示にする場合は nil を設定する)
(setq elscreen-display-tab t)
(define-key global-map (kbd "M-t") 'elscreen-next)
;;;;;;;;;;;;;;;;;ウィンドウ管理 END;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;テキスト編集管理 START;;;;;;;;;;;;;;;;;
; 行数表示
(global-linum-mode t)     ; 行番号を常に表示する
(setq linum-format "%4d|| ")

;;; 現在行を目立たせる
(global-hl-line-mode)

; ピーブ音を消す
(setq visible-bell t)

; 対応する括弧を光らせる。
(show-paren-mode 1)

; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)

; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

(global-font-lock-mode t)

;; モードラインにファイルパス表示
(set-default 'mode-line-buffer-identification
           '(buffer-file-name ("%f") ("%b")))

;; TABの表示幅。初期値は8
(setq-default tab-width 4)

;; system-type predicates
;; from http://d.hatena.ne.jp/tomoya/20090807/1249601308
(setq darwin-p   (eq system-type 'darwin)
      linux-p    (eq system-type 'gnu/linux)
      carbon-p   (eq system-type 'mac)
      meadow-p   (featurep 'meadow))

;; MAC OSXのファイル名設定
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

; Emacs と Mac のクリップボード共有
; from http://hakurei-shain.blogspot.com/2010/05/mac.html
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(if (or darwin-p carbon-p)
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx))

(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))


;; 時間挿入
(defun my-get-date-gen (form) (insert (format-time-string form)))
(defun my-get-date() (interactive) (my-get-date-gen "--------------------<<<%Y/%m/%d>>>--------------------"))
;; C-xC-dで時間挿入できるようにする
(global-set-key "\C-x\C-d" 'my-get-date)
;;;;;;;;;;;;;;;;;テキスト編集管理 END;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;; anything START;;;;;;;;;;;;;;;;;
(require 'anything)
(require 'anything-startup)
(setq anything-sources
      '(anything-c-source-buffers+
				;anything-c-source-colors
				anything-c-source-recentf
        ;anything-c-source-man-pages
				anything-c-source-files-in-current-dir
				anything-c-source-emacs-commands
				anything-c-source-emacs-functions
				))
(anything-read-string-mode 1)
(define-key global-map (kbd "C-x b") 'anything)
(global-set-key "\M-y" 'anything-show-kill-ring)
;;(define-key global-map (kbd "C-x C-f") 'anything-find-file)
;; 遅延を短く
(setq anything-idle-delay 0.2)
(setq anything-input-idle-delay 0.2)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; auto-completeの設定
(when (require 'auto-complete-config nil t)
	(ac-config-default)
	(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
	(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
	(add-to-list 'ac-modes 'org-mode)
	(add-to-list 'ac-modes 'yatex-mode)
	(ac-set-trigger-key "TAB")
	(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
;;	(setq ac-use-fuzzy t)          ;; 曖昧マッチ
)
;;;;;;;;;;;;;;;;; anything END;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; 履歴管理 START;;;;;;;;;;;;;;;;;
;; undohistの設定
(when (require 'undohist nil t)
  (undohist-initialize)
)

;;undo-treeの設定
(when (require 'undo-tree nil t)
	(global-undo-tree-mode)
)
;;;;;;;;;;;;;;;;; 履歴管理 END;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; 短形モード START;;;;;;;;;;;;;;;;;
;; cua-modeの設定
(cua-mode t) ; cua-modeをオン
(setq cua-enable-cua-keys nil) ;; CUAキーバインドを無効にする
;;;;;;;;;;;;;;;;; 短形モード END;;;;;;;;;;;;;;;;;


; 分割設定ファイルロード
;; rubyモード
(load "init-ruby")
