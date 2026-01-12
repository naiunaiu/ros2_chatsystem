#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 Satoh-Narumi
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd /root/ros2_ws
mv src/pkg_kadai2/pkg_kadai2/player1.py src/pkg_kadai2/pkg_kadai2/player2.py
mv src/pkg_kadai3/pkg_kadai3/player1.py src/pkg_kadai3/pkg_kadai3/player3.py
ls /root/ros2_ws/src/pkg_kadai2
ls /root/ros2_ws/src/pkg_kadai3
sed -i "s@'player1 = pkg_kadai.player1:main',@'player2 = pkg_kadai2.player2:main',@g" /root/ros2_ws/src/pkg_kadai2/setup.py
sed -i "s@'player1 = pkg_kadai.player1:main',@'player3 = pkg_kadai3.player3:main',@g" /root/ros2_ws/src/pkg_kadai3/setup.py
cd /root/ros2_ws
colcon build
source install/setup.bash

echo 'taste' | ros2 run pkg_kadai player1 > /tmp/pkg_kadai.log
cat /tmp/pkg_kadai.log | grep 'player1:No connection with partner'
sleep 1
echo 'test' | ros2 run pkg_kadai2 player2 >> /tmp/pkg_kadai2.log
echo 'torst' | ros2 run pkg_kadai3 player3 >> /tmp/pkg_kadai3.log
cat /tmp/pkg_kadai.log | grep 'player1:torst'
cat /tmp/pkg_kadai2.log | grep 'player2:taste'
cat /tmp/pkg_kadai3.log | grep 'player3:test'