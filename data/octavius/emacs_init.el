(setq delete-old-versions -1 )		; delete excess backup versions silently
(setq version-control t )		    ; use version control
(setq vc-make-backup-files t )		; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )		; don't ask for confirmation when opening symlinked file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
(setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )	; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 )	; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
(setq default-fill-column 80)		; toggle wrapping text at the 80th character
(setq initial-scratch-message
      "
Test 0
Test 1
Test 2
") ; a default message in the empty scratch buffer opened at startup

(setq-default frame-title-format '("%b [%m] - emacs")) ; set the emacs title. overrides the old "emacs@HOST" title
(setq-default indent-tabs-mode nil) ; don't insert tabs
(setq-default tab-width 4) ; self-documenting
(setq indent-line-function 'insert-tab)

(require 'package)

(setq package-enable-at-startup nil) ; tells emacs not to load any packages before starting up
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; update packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package

(require 'use-package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (manoj-dark)))
 '(fringe-mode 0 nil (fringe))
 '(indent-tabs-mode nil)
 '(linum-relative-current-symbol "")
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (counsel-projectile neotree projectile nov rainbow-delimiters json-mode beacon linum-relative evil counsel swiper ivy which-key avy general use-package)))
 '(scroll-bar-mode nil)
 '(tab-width 4)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package general :ensure t
  :config
  (general-define-key "C-'" 'avy-goto-word-1)
  )

; Packages
(use-package avy :ensure t
  :commands (avy-goto-word-1))

(use-package ivy :ensure t)
(use-package swiper :ensure t)
(use-package counsel :ensure t)
(use-package evil :ensure t)

; Custom keybindings
(general-define-key
  ;; replace default keybindings
  "C-s" 'swiper             ; search for string in current buffer
  "M-x" 'counsel-M-x        ; replace default M-x with ivy backend
  )

(general-define-key
 :prefix "C-c"
 ;; bind to simple key press
  "b"	'ivy-switch-buffer  ; change buffer, chose using ivy
  "/"   'counsel-git-grep   ; find string in git project
  ;; bind to double key press
  "f"   '(:ignore t :which-key "files")
  "ff"  'counsel-find-file  ; find file using ivy
  "fr"	'counsel-recentf    ; find recently edited files
  "p"   '(:ignore t :which-key "project")
  "pf"  '(counsel-git :which-key "find file in git dir") ; find file in git project
  )

; File / directory related
(general-define-key
 :prefix "C-M-S-f"
 "f" 'counsel-find-file ; find file using ivy
 "r" 'counsel-recentf   ; find recently edited files
 "p" 'counsel-projectile-find-file ; find file in current project
 )

; Window related
(general-define-key
 :prefix "C-M-S-w"
 "v" 'split-window-below
 "h" 'split-window-right
 "z" 'maximize-window
 "o" 'delete-other-windows
 )

; Toggles
(general-define-key
 :prefix "C-M-S-t"
 "w" 'whitespace-mode
 "t" 'neotree-toggle
 )

; Oner chords
(general-define-key
 "C-M-S-x" 'kill-buffer
 "C-M-S-c" 'delete-window
 "C-M-S-b" 'ivy-switch-buffer
 "C-M-S-h" 'windmove-left
 "C-M-S-j" 'windmove-down
 "C-M-S-k" 'windmove-up
 "C-M-S-l" 'windmove-right
 "C-M-?" 'swiper
 )

; prog2 bindings
(general-define-key
 "C-S-h" 'shrink-window-horizontally
 "C-S-j" 'enlarge-window
 "C-S-k" 'shrink-window
 "C-S-l" 'enlarge-window-horizontally
 )

; Spacemacs-like chords
(use-package general :ensure t
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

    ;; simple command
    "'"   '(iterm-focus :which-key "iterm")
    "?"   '(iterm-goto-filedir-or-home :which-key "iterm - goto dir")
    "/"   'counsel-ag
    "TAB" '(switch-to-other-buffer :which-key "prev buffer")
    "SPC" '(avy-goto-word-or-subword-1  :which-key "go to char")

    ;; Applications
    "a" '(:ignore t :which-key "Applications")
    "ar" 'ranger
    "ad" 'dired))
 

(evil-mode t)
(which-key-mode t)
(beacon-mode 1)

(use-package linum-relative :ensure t)
(linum-relative-global-mode)

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)) ; For ebook reading

; Neotree keybindings conflict with evil-mode
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

