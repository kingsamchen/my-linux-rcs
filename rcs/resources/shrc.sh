
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ -n "$SSH_CLIENT" -a -n "$DISPLAY" ]; then
    bindkey '^[[H' beginning-of-line
    bindkey '^[[F' end-of-line
fi

# Setup for Golang
if [ -d "/usr/local/go" ]; then
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/go
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

    export GO111MODULE=on
    export GOPROXY=https://goproxy.cn
fi

function goproxy.default {
    export GOPROXY=https://goproxy.cn
}

function goproxy.bili {
    export GOPROXY=http://goproxy.bilibili.co
}

LOCAL_BIN="$HOME/.local/bin"
if [ -d $LOCAL_BIN ]; then
    export PATH=$LOCAL_BIN:$PATH
fi

[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

export PATH=$HOME/projects/anvil/launcher:$PATH

rbg() {
    $1 > /dev/null 2>&1 &
}

