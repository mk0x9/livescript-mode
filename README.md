# LiveScript Major Mode

Basic LiveScript support for Emacs editor. At this moment supports only compiling buffer contents to JavaScript.

## Setting up

1. Add directory with extension to ````load-path````

   ````(add-to-list 'load-path "~/.emacs.d/site-lisp/livescript-mode")````
2. Require ````livescript-mode````

   ````(require 'livescript-mode)````
3. Define hotkey for compiling buffer contents (e.g. ````C-c C-l````)

   ````(define-key livescript-mode-map "\C-c\C-l" 'livescript-compile-buffer)````
