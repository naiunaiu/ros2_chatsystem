#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 Satoh-Narumi
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd /root/ros2_ws
cp src/pkg_kadai/pkg_kadai/player1.py src/pkg_kadai/pkg_kadai/player2.py
cd /root/ros2_ws
colcon build
source install/setup.bash

echo 'taste' | timeout 10 ros2 run pkg_kadai player1 > /tmp/pkg_kadai.log
echo 'test' | timeout 10 ros2 run pkg_kadai player2 > /tmp/pkg_kadai.log
cat /tmp/pkg_kadai.log | grep 'player1:taste'
cat /tmp/pkg_kadai.log | grep 'player2:test'

rm src/pkg_kadai/pkg_kadai/player2.py