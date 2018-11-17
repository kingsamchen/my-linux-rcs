
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

# Setup for Golang
if [ -d "/usr/local/go" ]; then
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/go
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
fi

# Set dbus for remote SSH connections
if [ -n "$SSH_CLIENT" -a -n "$DISPLAY" ]; then
    machine_id=$(LANGUAGE=C hostnamectl|grep 'Machine ID:'| sed 's/^.*: //')
    x_display=$(echo $DISPLAY|sed 's/^.*:\([0-9]\+\)\(\.[0-9]\+\)*$/\1/')
    dbus_session_file="$HOME/.dbus/session-bus/${machine_id}-${x_display}"
    if [ -r "$dbus_session_file" ]; then
            export $(grep '^DBUS.*=' "$dbus_session_file")
            # check if PID still running, if not launch dbus
            ps $DBUS_SESSION_BUS_PID | tail -1 | grep dbus-daemon >& /dev/null
            [ "$?" != "0" ] && export $(dbus-launch) >& /dev/null
    else
            export $(dbus-launch) >& /dev/null
    fi
fi
