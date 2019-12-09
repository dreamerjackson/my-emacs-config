;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.


;; "When several buffers visit identically-named files,
;; Emacs must give the buffers distinct names. The usual method
;; for making buffer names unique adds ‘<2>’, ‘<3>’, etc. to the end
;; of the buffer names (all but one of them).
;; The forward naming method includes part of the file's directory
;; name at the beginning of the buffer name
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Turn on recent file mode so that you can more easily switch to
;; recently edited files when you first start emacs
(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 40)
(setq recentf-max-saved-items 150)


(winner-mode 1)

;; (use-package ace-window
;;   :ensure t
;;   :init
;;   (progn
;;     (global-set-key [remap other-window] 'ace-window)
;;     (custom-set-faces
;;      '(aw-leading-char-face
;;        ((t (:inherit ace-jump-face-foreground :height 3.0))))) 
;;     ))

;;
;; ivy mode
;;
(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :config
  (ivy-mode 1)
  (setq ivy-use-virutal-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 10)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "%d/%d")
  (setq ivy-re-builders-alist
        `((t . ivy--regex-ignore-order)))
  )

;;
;; counsel
;;
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("\C-x \C-f" . counsel-find-file)))

;;
;; swiper
;;
(use-package swiper
  :ensure t
  :bind (("\C-s" . swiper))
  )


(use-package ag
  :ensure-system-package (ag . "brew install the_silver_searcher")
  )

(use-package helm-gtags
  :ensure t
  :config
  (setq helm-gtags-ignore-case t
        helm-gtags-auto-update t
        helm-gtags-use-input-at-cursor t
        helm-gtags-pulse-at-cursor t
        helm-gtags-prefix-key "\C-cg"
        helm-gtags-suggested-key-mapping t)
  :bind (:map helm-gtags-mode-map
              ("\C-c g a" . helm-gtags-tags-in-this-function)
              ("\C-j" . helm-gtags-select)
              ("M-." . helm-gtags-dwim)
              ("M-," . helm-gtags-pop-stack)
              ("\C-c <" . helm-gtags-previous-history)
              ("\C-c >" . helm-gtags-next-history))
  :hook ((dired-mode eshell-mode c-mode c++-mode asm-mode) . helm-gtags-mode))

(use-package sr-speedbar
  :config
  (setq speedbar-show-unknown-files t ;; show all files
        speedbar-use-images nil       ;; use text for buttons
        sr-speedbar-right-side nil    ;; put on left side
        sr-speedbar-width 30
        )
  :bind (("C-c s o" . sr-speedbar-toggle)
         ("C-c s w" . sr-speedbar-select-window)
         ("C-c s r" . sr-speedbar-refresh-toggle)))


;;
;; projectile
;;
(use-package projectile
  :ensure t
  :bind-keymap
  ("\C-c p" . projectile-command-map)
  :config
  (projectile-mode t)
  (setq projectile-completion-system 'ivy)
  (use-package counsel-projectile
    :ensure t)
  )


;; for  buffer
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
;; avy



;; (use-package avy
;;   :ensure t
;;   :bind ("M-s" . avy-goto-char))

(defalias 'list-buffers 'ibuffer)

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config 
  ;; (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
:init
(dumb-jump-mode)
  :ensure
  )

;; (defun my/ido-recentf-open ()
;;   "Use `ido-completing-read' to find a recent file."
;;   (interactive)
;;   (if (find-file (ido-completing-read "Find recent file: " recentf-list))
;;       (message "Opening file...")
;;     (message "Aborting")))

;; (global-set-key (kbd "C-x f") 'my/ido-recentf-open)

;; ;; ido-mode allows you to more easily navigate choices. For example,
;; ;; when you want to switch buffers, ido presents you with a list
;; ;; of buffers in the the mini-buffer. As you start to type a buffer's
;; ;; name, ido will narrow down the list of buffers to match the text
;; ;; you've typed in
;; ;; http://www.emacswiki.org/emacs/InteractivelyDoThings
;; (ido-mode t)

;; ;; This allows partial matches, e.g. "tl" will match "Tyrion Lannister"
;; (setq ido-enable-flex-matching t)

;; ;; Turn this behavior off because it's annoying
;; (setq ido-use-filename-at-point nil)

;; ;; Don't try to match file across all "work" directories; only match files
;; ;; in the current directory displayed in the minibuffer
;; (setq ido-auto-merge-work-directories-length -1)

;; ;; Includes buffer names of recently open files, even if they're not
;; ;; open now
;; (setq ido-use-virtual-buffers t)

;; ;; This enables ido in all contexts where it could be useful, not just
;; ;; for selecting buffer and file names
;; (ido-ubiquitous-mode 1)

;; ;; Shows a list of buffers
;; (global-set-key (kbd "C-x C-b") 'ibuffer)


;; ;; Enhances M-x to allow easier execution of commands. Provides
;; ;; a filterable list of possible commands in the minibuffer
;; ;; http://www.emacswiki.org/emacs/Smex
;; (setq smex-save-file (concat user-emacs-directory ".smex-items"))
;; (smex-initialize)
;; (global-set-key (kbd "M-x") 'smex)

