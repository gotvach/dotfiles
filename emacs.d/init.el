(require 'package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auto-revert-verbose nil)
 '(column-number-mode t)
 '(compilation-message-face 'default)
 '(custom-enabled-themes '(cyberpunk))
 '(custom-safe-themes
   (quote
    ("b89a4f5916c29a235d0600ad5a0849b1c50fab16c2c518e1d98f0412367e7f97" "2d835b43e2614762893dc40cbf220482d617d3d4e2c35f7100ca697f1a388a0e" "6bc387a588201caf31151205e4e468f382ecc0b888bac98b2b525006f7cb3307" "d1cc05d755d5a21a31bced25bed40f85d8677e69c73ca365628ce8024827c9e3" "d6922c974e8a78378eacb01414183ce32bc8dbf2de78aabcc6ad8172547cb074" "235dc2dd925f492667232ead701c450d5c6fce978d5676e54ef9ca6dd37f6ceb" "38e64ea9b3a5e512ae9547063ee491c20bd717fe59d9c12219a0b1050b439cdd" "e64111716b1c8c82638796667c2c03466fde37e69cada5f6b640c16f1f4e97df" "71ecffba18621354a1be303687f33b84788e13f40141580fa81e7840752d31bf" default)))
 '(desktop-save-mode t)
 '(face-font-family-alternatives
   (quote
    (("Monospace" "courier" "fixed" "DejaVu Sans Mono")
     ("courier" "CMU Typewriter Text" "fixed")
     ("Sans Serif" "helv" "helvetica" "arial" "fixed")
     ("helv" "helvetica" "arial" "fixed"))))
 '(fci-rule-color "#49483E")
 '(flymake-gui-warnings-enabled nil)
 '(font-use-system-font nil)
 '(global-auto-revert-mode t)
 '(gnus-select-method (quote (nntp "news.gmane.org")))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type 'cabal-repl)
 '(haskell-tags-on-save t)
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   '(("#49483E" . 0)
     ("#67930F" . 20)
     ("#349B8D" . 30)
     ("#21889B" . 50)
     ("#968B26" . 60)
     ("#A45E0A" . 70)
     ("#A41F99" . 85)
     ("#49483E" . 100)))
 '(hl-line-mode t t)
 '(icon-mode nil)
 '(ido-mode (quote both) nil (ido))
 '(linum-format " %3d ")
 '(linum-mode t t)
 '(magit-diff-use-overlays nil)
 '(menu-bar-mode nil)
 '(minibuffer-message-timeout 5 t)
 '(ns-antialias-text nil)
 '(org-agenda-custom-commands
   '(("n" "Agenda and all TODO's"
      ((agenda "" nil)
       (alltodo "" nil)
       (todo "NEXT" nil))
      nil)
     ("N" "NEXT in queue"
      ((todo "NEXT" nil))
      nil nil))))
 '(org-agenda-files nil)
 '(org-confirm-babel-evaluate nil)
 '(package-enable-at-startup nil)
 '(package-selected-packages
   (quote
    (org-journal-list org-journal auto-org-md flycheck-mmark flymd markdown-mode markdown-toc visual-fill-column rotate dante intero haskell-snippets evil magit magit-gitflow smex smartparens s request multiple-cursors flymake-puppet flycheck-package expand-region evil-surround dummyparens cyberpunk-theme company auto-complete)))
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
 '(puppet-lint-command
   "puppet-lint --no-autoloader_layout-check --with-context --log-format \"%{path}:%{line}: %{kind}: %{message} (%{check})\"")
 '(revert-without-query (quote (".*")))
 '(server-mode t)
 '(show-paren-mode t)
 '(split-width-threshold 80)
 '(syslog-debug-face
   '((t :background unspecified :foreground "#A1EFE4" :weight bold)))
 '(syslog-error-face
   '((t :background unspecified :foreground "#F92672" :weight bold)))
 '(syslog-hour-face '((t :background unspecified :foreground "#A6E22E")))
 '(syslog-info-face
   '((t :background unspecified :foreground "#66D9EF" :weight bold)))
 '(syslog-ip-face '((t :background unspecified :foreground "#E6DB74")))
 '(syslog-su-face '((t :background unspecified :foreground "#FD5FF0")))
 '(syslog-warn-face
   (quote
    ((t :background unspecified :foreground "#FD971F" :weight bold))))
 '(toggle-scroll-bar t)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#272822" "#49483E" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#1d1f27" :foreground "#fff9ec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "PfEd" :family "DejaVu Sans Mono")))))

;; Other packages
(setq package-list
      '(
        auto-complete
        company
        company-go
        cyberpunk-theme
        dummyparens
        evil
        expand-region
        flycheck-package
        flymake-puppet
        haskell-snippets
        multiple-cursors
        org-journal
        s
        smartparens
        smex
        undo-tree
        ))

;;
;; Pin GHC due to: unknown command map-file
;; (when (boundp 'package-pinned-packages)
;;   (setq package-pinned-packages
;;         '((ghc . "melpa-stable"))))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;(require 'ess-site)
(require 'org-install)
(org-babel-load-file
 (expand-file-name "settings.org"
                   user-emacs-directory))

;;;;;;;;;;;;;;;;;;;;;

;; SMEX -> M-x alternative
(require 'smex)
(global-set-key (kbd "M-x") 'smex)

(defalias 'yes-or-no-p 'y-or-n-p)
