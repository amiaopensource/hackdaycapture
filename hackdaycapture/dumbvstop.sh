#!/bin/bash
# probably buggy, but kills the first process with ffmpeg in it
FFMPEG_PID=$(ps ux | grep "bin/ffmpeg" | head -n 1 | awk '{print $2}')
kill "${FFMPEG_PID}"
sleep 2
FFPLAY_PID=$(ps ux | grep "bin/ffplay" | head -n 1 | awk '{print $2}')
kill "${FFPLAY_PID}"
