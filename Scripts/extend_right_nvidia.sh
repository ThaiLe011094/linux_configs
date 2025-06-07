#!/bin/bash

xrandr --output eDP-1-1 --left-of HDMI-0 --mode 2560x1440 --rate 165.00 && xrandr --output HDMI-0 --primary --mode 2560x1440 --rate 144.00
