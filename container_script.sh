#!/usr/bin/env bash
set -euo pipefail

export DISPLAY=:99

timeout=20

# Start and wait for either Xvfb to be fully up or we hit the timeout.
echo "launching xvfb and fluxbox"
xvfb-run --listen-tcp --server-num=99 -s "-ac -screen 0 1920x1067x24" -- fluxbox > /tmp/xvfb_logs 2>&1 &

echo "checking for xvfb to be fully up"
loopCountXvfb=0
until xdpyinfo -display ${DISPLAY} > /dev/null 2>&1
do
    loopCountXvfb=$((loopCountXvfb+1))
    sleep 1
    if [ ${loopCountXvfb} -gt ${timeout} ]
    then
        echo "xvfb failed to start. See logs below."
        cat /tmp/xvfb_logs
        exit 1
    fi
done
echo "xvfb is fully up"
echo "checking for fluxbox to be fully up"
loopCountFluxbox=0
until wmctrl -m > /dev/null 2>&1
do
    loopCountFluxbox=$((loopCountFluxbox+1))
    sleep 1
    if [ ${loopCountFluxbox} -gt ${timeout} ]
    then
        echo "fluxbox failed to start. See logs below."
        cat /tmp/xvfb_logs
        exit 1
    fi
done
echo "fluxbox is fully up"

# start x11vnc server
x11vnc -passwd password -display ${DISPLAY} -N -forever -rfbport 5920 &

exec /opt/Citrix/ICAClient/wfica.sh launch.ica
