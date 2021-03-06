
;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell

(when (memq window-system '(mac ns x))
  ;; emacs run inside terminal will inherit env from shell
  (when (display-graphic-p)
    (use-package exec-path-from-shell
      :config
      (exec-path-from-shell-copy-envs
       '("GOPROXY" "GOPATH"))
      (exec-path-from-shell-initialize))))

