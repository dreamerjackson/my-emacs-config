(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(defun my/indent-org-block ()
  (interactive)
  (when (org-in-src-block-p)
    (org-edit-special)
    (indent-region (point-min) (point-max))
    (org-edit-src-exit)))

;; https://stackoverflow.com/a/47850858/2163429
(defun org-export-output-file-name-modified (orig-fun extension &optional subtreep pub-dir)
  (unless pub-dir
    (setq pub-dir "/tmp")
    (unless (file-directory-p pub-dir)
      (make-directory pub-dir)))
  (apply orig-fun extension subtreep pub-dir nil))

(use-package ox-gfm
  :after org)

(use-package htmlize
  :after org)

(use-package org
  :bind (:map org-mode-map
              ("C-c s" . org-table-sort-lines)
              ("C-c y" . org-metaleft)
              ("C-c u" . org-metaright)
              ("C-t C-c" . org-toggle-checkbox)
              ("C-t C-d" . org-insert-todo-heading))
  ("C-c C-l" . org-insert-link)
              
  :init
  (setq org-src-tab-acts-natively t
        ;; 代码区域禁用第一层缩进 https://emacs.stackexchange.com/a/18892/16450
        org-src-preserve-indentation t
        org-log-done 'time
        org-startup-folded "showall"
        org-startup-indented t
        org-image-actual-width nil
        ;; terminal emacs can't display those lovely images :-(
        org-startup-with-inline-images t)
  ;; markdown export require emacs 25 https://stackoverflow.com/a/33033533/2163429
  (require 'ox-md nil t)

  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.6 :bold t))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.4 :bold t))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.2 :bold t))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.0 :bold t))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.0 :bold t))))
   )
  ;; #+LaTeX_HEADER: \usepackage{CJK}
  ;; #+LaTeX_HEADER: \begin{CJK}{UTF8}{gbsn}
  (add-to-list 'org-latex-packages-alist '("" "CJKutf8" t))

  (advice-add 'org-export-output-file-name :around #'org-export-output-file-name-modified)

  (setq org-publish-project-alist
        '(("org-notes"
           :base-directory "~/study-note/"
           :base-extension "org"
           :publishing-directory "~/Documents/public_notes"
           :recursive t
           :publishing-function org-html-publish-to-html
           :headline-levels 4             ; Just the default for this project.
           :auto-preamble t)

          ("org-static"
           :base-directory "~/study-note/"
           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
           :publishing-directory "~/Documents/public_notes"
           :recursive t
           :publishing-function org-publish-attachment))))

(use-package org-download
  :ensure-system-package (pngpaste . "brew install pngpaste")
  :bind (:map org-mode-map
              ("C-c v" . org-download-screenshot)
              ("C-c d" . org-download-delete))
  :config
  (add-hook 'dired-mode-hook 'org-download-enable)
  (setq-default org-download-heading-lvl nil
                org-download-image-dir "./img"
                ;; org-download-screenshot-method "screencapture -i %s"
                org-download-image-org-width 600
                org-download-screenshot-method "pngpaste %s"
                org-download-screenshot-file (expand-file-name "screenshot.jpg" temporary-file-directory))
  (setq org-download-annotate-function (lambda (link) "")))


;;
(setq package-check-signature nil)
;
(define-key org-mode-map (kbd "C-c C-x l") nil)
(define-key org-mode-map (kbd "C-c C-x r") nil)
;;;;;;;;;;;
;; (use-package org-gcal
;;   :after org
;;   :ensure t
;;   :config
;;   ;;(org-gcal-sync)
;;   (setq org-gcal-client-id "1077987452195-7p6kqbjarg275fqpc5bd8htptrebsh6f.apps.googleusercontent.com"
;;         org-gcal-client-secret "jW18X_WrgTSA7Dx0qD5MHkmc"
;;         org-gcal-file-alist '(("zhuimengshaonian04@gmail.com" .  "~/my-note-project/gcal.org")))
;;   ;;(add-hook 'org-agenda-mode-hook 'org-gcal-fetch)
;;   ;;(add-hook 'org-agenda-mode-hook 'org-gcal-sync)
;;   ;;(add-hook 'org-capture-after-finalize-hook 'org-gcal-sync)
;;   )
 

    (global-set-key "\C-ca" 'org-agenda)
    (setq org-agenda-start-on-weekday nil)
    (setq org-agenda-custom-commands
          '(("c" "Simple agenda view"
             ((agenda "")
              (alltodo "")))))

    (global-set-key (kbd "C-c c") 'org-capture)

(setq org-agenda-files (list "~/my-note-project/todo.org"
                             "~/my-note-project/work.org"
                             "~/my-note-project/thinking.org"
                             "~/my-note-project/study.org"
                             "~/my-note-project/career.org"
                              "~/my-note-project/life.org"
                                ;;"~/my-note-project/gcal.org"
                                ;; "~/my-note-project/soe-cal.org"
                                ;; "~/my-note-project/i.org"
                                ;; "~/my-note-project/schedule.org"
                                 ))
    (setq org-capture-templates
          '(("a" "Appointment" entry (file  "~/my-note-project/gcal.org" )
             "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
            ("l" "Link" entry (file+headline "~/my-note-project/links.org" "Links")
             "* %? %^L %^g \n%T" :prepend t)
            ("b" "Blog idea" entry (file+headline "~/my-note-project/i.org" "Blog Topics:")
             "* %?\n%T" :prepend t)
            ("t" "To Do Item" entry (file+headline "~/my-note-project/i.org" "To Do and Notes")
             "* TODO %?\n%u" :prepend t)
            ("m" "Mail To Do" entry (file+headline "~/my-note-project/i.org" "To Do and Notes")
             "* TODO %a\n %?" :prepend t)
            ("g" "GMail To Do" entry (file+headline "~/my-note-project/i.org" "To Do and Notes")
             "* TODO %^L\n %?" :prepend t)
            ("n" "Note" entry (file+headline "~/my-note-project/i.org" "Notes")
             "* %u %? " :prepend t)
            ))


;; https://emacs-china.org/t/topic/440
(use-package cnfonts
  :config
  (when (display-graphic-p)
    (cnfonts-enable)
    (setq cnfonts-profiles
          '("program" "org-mode" "read-book"))
    (global-set-key (kbd "<f5>") 'cnfonts-increase-fontsize)
    (global-set-key (kbd "<f6>") 'cnfonts-decrease-fontsize)))
