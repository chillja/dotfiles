# no beep sound when complete list displayed
setopt nolistbeep

# Set comments inline
setopt interactivecomments

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey '^R' history-incremental-search-backward

# export original variable
# Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups  # ignore duplication command history list
setopt hist_ignore_space # ignore when commands starts with space
setopt share_history     # share command history data

export PATH="$HOME/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export ASEPRITE_ACCEPT_EULA=yes

export HAXE_STD_PATH="/usr/local/lib/haxe/std"
export ADBI_INSTALL_PATH="$HOME/Dropbox/Projects/Builds/"
export UNITY_INSTALL_PATH="$HOME/Dropbox/Projects/Builds/"
export UNITY_PROJECTS_PATH="$HOME/Projects/Games/Unity/"

alias vimconfig="nvim ~/.vim/vimrc"
alias zshconfig="nvim ~/.zshrc"
alias tmuxconfig="nvim ~/.tmux.conf"
alias tmuxreload="tmux source-file ~/.tmux.conf"
alias zshreload="source ~/.zshrc"
alias vim="nvim"
alias vimdiff="nvim -d"
alias vi="vim -u $HOME/.vim/vimrcmin"
alias tim="nvim -u $HOME/.vim/test.vim"
alias ls="ls --color=auto"
alias ag='ag --path-to-ignore ~/.agignore'
alias tre='tree -C -L 2'
alias slackmojify="mogrify -resize 128x128 -unsharp 2x1.4+0.5+0 -quality 100 -verbose"
alias prp="pipenv run python"

# Cumpletitions https://github.com/rust-lang-nursery/rustup.rs/blob/master/README.md
fpath+=~/.zfunc

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # http://stackoverflow.com/questions/18880024/start-ssh-agent-on-login
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    export PIPENV_VENV_IN_PROJECT=1
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    export LIBRARY_PATH="/usr/local/lib"
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="/Applications/Transmission.app/Contents/MacOS/:$PATH"
    export PATH="/Library/TeX/texbin:$PATH"
    export PATH="$HOME/Library/Python/2.7/bin:$PATH"
    alias ctags="`brew --prefix`/bin/ctags"
    export OPENSSL_INCLUDE_DIR=`brew --prefix openssl`/include
    export OPENSSL_LIB_DIR=`brew --prefix openssl`/lib
    # https://github.com/sfackler/rust-openssl/issues/255

    # https://stackoverflow.com/questions/1348842/what-should-i-set-java-home-to-on-osx
    export JAVA_HOME=$(/usr/libexec/java_home)
    export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src/"
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
else
        # Unknown.
fi

export EDITOR=nvim
export MANPAGER="nvim -c 'set ft=man' -"

# -- Vim Mode --
# autoload -z edit-command-line 
# zle -N edit-command-line
# bindkey "^X^E" edit-command-line
# bindkey -M vicmd v edit-command-line
# bindkey -v
# export KEYTIMEOUT=1

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# ZPLUG config and load
if [ -d /usr/local/opt/zplug ]; then
    ZPLUG_HOME=/usr/local/opt/zplug
elif [ -d $HOME/.zplug ]; then
    ZPLUG_HOME=$HOME/.zplug
fi

export ZPLUG_HOME
source $ZPLUG_HOME/init.zsh

# Plugins

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/git", from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/cargo", from:oh-my-zsh, use:"plugins/cargo/_cargo"
zplug "plugins/ssh-agent", from:oh-my-zsh, use:"plugins/ssh-agent/ssh-agent.plugin.zsh"
zplug "lib/clipboard", from:oh-my-zsh, use:"lib/clipboard.zsh",if:"[[ $OSTYPE == *darwin* ]]"
zplug "lib/directories", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "unixorn/git-extra-commands"

# Go up in the directory tree without aliases
zplug "peterhurford/up.zsh"

# zsh-substring-search
# You can type in any part of any command from history,
# press chosen keys and cycle through matches.
# https://github.com/zsh-users/zsh-history-substring-search
zplug "zsh-users/zsh-history-substring-search"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# zsh-syntax-highlighting
# Syntax highlighing for the command line.
# https://github.com/zsh-users/zsh-syntax-highlighting
zplug "zsh-users/zsh-syntax-highlighting", defer:3

# alias-tips
# Reminds you of aliases you have already.
# https://github.com/djui/alias-tips
zplug "djui/alias-tips", defer:2

# extract
# Extracts a wide variety of archive formats.
# https://github.com/xvoland/Extract
zplug "xvoland/Extract", use:"*.sh"

# Directory listings for zsh with git features.
# https://github.com/supercrabtree/k
zplug "supercrabtree/k"

# z
# Navigate your most used directories based on 'frecency'.
# https://github.com/rupa/z
zplug "rupa/z", use:"*.sh"

# A simple zsh function to make management of zsh named directories easier. 
# https://github.com/MikeDacre/cdbk
zplug "MikeDacre/cdbk"

zplug "baskerville/bspwm", use: "contrib/zsh_completion"
zplug "jonas/tig", use: "contrib/tig-completion.zsh"

zplug "sferik/t", use: "etc/t-completion.zsh"
# Theme
# zplug "arlefreak/odin", defer:19
# zplug "~/.zsh/Odin", from:local, defer:19
zplug "subnixr/minimal"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose
