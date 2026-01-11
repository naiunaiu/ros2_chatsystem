#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 Satoh-Narumi
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd /root/ros2_ws
mv src/pkg_kadai/pkg_kadai2/player1.py player2.py
mv src/pkg_kadai/pkg_kadai3/player1.py player3.py
colcon build
source install/setup.bash

echo 'taste' | timeout 10 ros2 run pkg_kadai player1 > /tmp/pkg_kadai.log
echo 'test' | timeout 10 ros2 run pkg_kadai2 player2 >> /tmp/pkg_kadai2.log
echo 'torst' | timeout 10 ros2 run pkg_kadai3 player3 >> /tmp/pkg_kadai3.log
cat /tmp/pkg_kadai.log | grep 'player1:taste'
cat /tmp/pkg_kadai2.log | grep 'player2:test'
cat /tmp/pkg_kadai3.log | grep 'player3:torst'

#以下例外処理

timeout 10 ros2 run pkg_kadai player1 >> /tmp/pkg_kadai.log
cat /tmp/pkg_kadai.log | grep 'player1:No connection with partner'