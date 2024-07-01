#!/bin/sh

trap "exit" TERM QUIT INT
trap "kill_putty" EXIT

kill_putty() {
    RC=$?

    if [ -n "${PUTTY_PID:-}" ]; then
        kill "$PUTTY_PID"
        wait $PUTTY_PID
        exit $?
    fi

    rm -f /tmp/.puttty_restart_requested
    exit $RC
}

export HOME=/config
cd "$HOME"

while true
do
    # Start PuTTY.
    /usr/bin/putty &

    # Wait until it dies.
    PUTTY_PID=$!
    wait $PUTTY_PID
    RC=$?
    PUTTY_PID=

    # Exit now if PuTTY exit was not requested by user.
    if [ ! -f /tmp/.puttty_restart_requested ]; then
        exit $RC
    fi

    rm /tmp/.puttty_restart_requested
done

# vim:ft=sh:ts=4:sw=4:et:sts=4
