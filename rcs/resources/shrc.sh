
# Do not source if not in the interactive shell.
case "$-" in
    *i*) ;;
    *) return
esac

if [ -n "$SSH_CLIENT" -a -n "$DISPLAY" ]; then
    _RUNNING_FROM_SSH_X=2
fi

if [ -n "$_RUNNING_FROM_SSH_X" ]; then
    bindkey "\033[1~" beginning-of-line
    bindkey "\033[4~" end-of-line
fi

# Setup for Golang
if [ -d "/usr/local/go" ]; then
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/go
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
fi

NODE_HOME="$HOME/Programs/node-v10.15.3-linux-x64"
if [ -d $NODE_HOME ]; then
    export PATH=$NODE_HOME/bin:$PATH
fi

LOCAL_BIN="$HOME/.local/bin"
if [ -d $LOCAL_BIN ]; then
    export PATH=$LOCAL_BIN:$PATH
fi

[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

