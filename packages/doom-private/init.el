;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load in.
;; Press 'K' on a module to view its documentation, and 'gd' to browse its directory.

(doom! :completion
       
       (company                     ; the ultimate code completion backend
        +childframe)                ; ... when your children are better than you
       ;;(vertico +icons)             ; the search engine of the future
       ;;helm              ; the *other* search engine for love and life
       ;;ido               ; the other *other* search engine...
       ivy               ; a search engine for love and life
       

       :ui
       
       ;;deft              ; notational velocity for Emacs
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       (emoji +unicode)  ; 🙂
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       hydra
       indent-guides     ; highlighted indent columns
       ;;(ligatures +extra); ligatures and symbols to make your code pretty again
       minimap           ; show a map of the code on the side
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink cursor line after big motions
       neotree           ; a project drawer, like NERDTree for vim
       ophints            ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       ;;tabs              ; a tab bar for Emacs
       ;;treemacs          ; a project drawer, like neotree but cooler
       unicode           ; extended unicode support for various languages
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows
       workspaces        ; tab emulation, persistence & separate workspaces
       zen               ; distraction-free coding or writing
       

       :editor
       
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       ;;(format +onsave)  ; automated prettiness
       ;;god               ; run Emacs commands without modifier keys
       ;;lispy             ; vim for lisp, for people who don't like vim
       multiple-cursors  ; editing in many places at once
       ;;objed             ; text object editing for the innocent
       ;;parinfer          ; turn lisp into python, sort of
       ;;rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to
       ;;word-wrap         ; soft wrapping with language-aware indent
       

       :emacs
       
       (dired +icons)    ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       (ibuffer +icons)  ; interactive buffer management
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree
       tramp
       

       :term
       
       eshell            ; the elisp shell that works everywhere
       ;;shell             ; simple shell REPL for Emacs
       term              ; basic terminal emulator for Emacs
       vterm             ; the best terminal emulation in Emacs
       

       :checkers
       
       syntax              ; tasing you for every semicolon you forget
       (:if (executable-find "aspell") spell) ; tasing you for misspelling mispelling
       (:if (executable-find "languagetool") grammar) ; tasing grammar mistake every you make
       

       :tools
       
       ;;ansible
       (debugger +lsp)   ; stepping through code, to help you add bugs
       direnv
       ;;docker
       editorconfig      ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)     ; run code, run (also, repls)
       ;;gist              ; interacting with github gists
       (lookup           ; helps you navigate your code and documentation
        +dictionary      ; dictionary/thesaurus is nice
        +docsets)        ; ...or in Dash docsets locally
       lsp
       ;;(lsp +eglot)               ; M-x vscode
       magit             ; a git porcelain for Emacs
       ;;make              ; run make tasks from Emacs
       ;;pass              ; password manager for nerds
       pdf               ; pdf enhancements
       ;;prodigy           ; managing external services & code builders
       rgb               ; creating color strings
       ;;taskrunner        ; taskrunner for all your projects
       ;;terraform         ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       ;;upload            ; map local to remote projects via ssh/ftp
       tree-sitter       ; Syntax and Parsing sitting in a tree
       

       :os
       
       (:if IS-MAC macos) ; improve compatibility with macOS
       

       :lang
       
       (agda +local)          ; types of types of types of types...
       ;;beancount         ; mind the GAAP
       cc                ; C > C++ == 1
       ;;clojure           ; java with a lisp
       common-lisp       ; if you've seen one lisp, you've seen them all
       coq               ; proofs-as-programs
       ;;crystal           ; ruby at the speed of c
       (csharp +lsp)      ; unity, .NET, and mono shenanigans
       ;;data              ; config/data formats
       ;;(dart +flutter)   ; paint ui and not much else
       elixir            ; erlang done right
       elm               ; care for a cup of TEA?
       emacs-lisp        ; drown in parentheses
       erlang            ; an elegant language for a more civilized age
       ;;ess               ; emacs speaks statistics
       ;;factor
       ;;faust             ; dsp, but you get to keep your soul
       fsharp            ; ML stands for Microsoft's Language
       ;;fstar             ; (dependent) types and (monadic) effects and Z3
       ;;gdscript          ; the language you waited for
       (go +lsp)         ; the hipster dialect
       ;; (haskell +dante)  ; a language that's lazier than I am
       (haskell +lsp) ; a language that's lazier than I am
       ;;hy                ; readability of scheme w/ speed of python
       idris             ; a language you can depend on
       json              ; At least it ain't XML
       ;;(java +meghanada) ; the poster child for carpal tunnel syndrome
       javascript        ; all(hope(abandon(ye(who(enter(here))))))
       julia             ; a better, faster MATLAB
       kotlin            ; a better, slicker Java(Script)
       (latex            ; writing papers in Emacs has never been so fun
        ;;+fold          ; fold the clutter away nicities
        +latexmk         ; modern latex plz
        ;;+cdlatex       ; quick maths symbols
        +lsp)
       ;;lean              ; for folks with too much to prove
       ;;ledger            ; be audit you can be
       lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       ;;nim               ; python + lisp at the speed of c
       nix               ; I hereby declare "nix geht mehr!"
       ocaml             ; an objective camel
       (org              ; organize your plain life in plain text
        ;;+pretty        ; yessss my pretties! (nice unicode symbols)
        +dragndrop       ; drag & drop files/images into org buffers
        +hugo          ; use Emacs for hugo blogging
        ;;+noter         ; enhanced PDF notetaking
        +jupyter         ; ipython/jupyter support for babel
        +pandoc          ; export-with-pandoc support
        +gnuplot         ; who doesn't like pretty pictures
        +pomodoro        ; be fruitful with the tomato technique
        +present       ; using org-mode for presentations
        +roam2)          ; wander around notes
       ;;php               ; perl's insecure younger brother
       ;;plantuml          ; diagrams for confusing people more
       purescript        ; javascript, but functional
       (python           ; beautiful is better than ugly
        +lsp
        +pyright
        +tree-sitter
        +cython)
       ;;qt                ; the 'cutest' gui framework ever
       racket            ; a DSL for DSLs
       ;;raku              ; the artist formerly known as perl6
       ;;rest              ; Emacs as a REST client
       ;;rst               ; ReST in peace
       (ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (rust +lsp +tree-sitter)  ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;; (scala +lsp)             ; java, but good
       (scheme +guile +chicken +racket)   ; a fully conniving family of lisps
       sh                ; she sells {ba,z,fi}sh shells on the C xor
       ;;sml
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       ;;terra             ; Earth and Moon in alignment for performance.
       ;;web               ; the tubes
       yaml              ; JSON, but readable
       ;;zig               ; C, but simpler
       

       :email
       
       ;;(mu4e +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)
       

       :app
       
       calendar
       ;;emms
       ;;everywhere        ; *leave* Emacs!? You must be joking
       ;;irc               ; how neckbeards socialize
       ;;(rss +org)        ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought
       

       :config
       
       literate
       (default +bindings +smartparens)
       )
