#!/bin/bash
if wmctrl -m | grep -q "mode: ON"; then
    wmctrl -k off
else
    wmctrl -k on
fi
