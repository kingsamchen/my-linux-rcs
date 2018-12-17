
# Avoid being loaded twice in interactive shell.
if [ -z "$_INIT_SH_LOADED" ]; then
    _INIT_SH_LOADED=1
else
    return
fi

# Do not source if not in the interactive shell.
case "$-" in
    *i*) ;;
    *) return
esac

if [ -n "$SSH_CLIENT" -a -n "$DISPLAY" ]; then
    _RUNNING_FROM_SSH_X=1
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
