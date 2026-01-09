#!/bin/bash

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
timeout 10 ros2 launch pkg_kadai player1.py > /tmp/pkg_kadai.log

cat /tmp/pkg_kadai.log | grep 