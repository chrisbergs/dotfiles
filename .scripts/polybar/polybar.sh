#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait a bit
sleep 0.2

# Launch polybar
MONITOR=$MONITOR1 polybar top &
MONITOR=$MONITOR2 polybar top2 &
