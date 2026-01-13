#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 Satoh-Narumi
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"
ng () {
	echo ${1}行目ダメよ
	res=1
}
res=0

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

timeout 4 ros2 run pkg_kadai player1 > /tmp/pkg_kadai.log 2>&1
sleep 2
cat /tmp/pkg_kadai.log
cat /tmp/pkg_kadai.log | grep 'No connection with partner' || ng "$LINENO"
(sleep 1; echo "taste") | timeout 10 ros2 run pkg_kadai player1 >> /tmp/pkg_kadai.log 2>&1
(sleep 1; echo "test") | timeout 10 ros2 run pkg_kadai2 player2 > /tmp/pkg_kadai2.log 2>&1
(sleep 1; echo "torst") | timeout 10 ros2 run pkg_kadai3 player3 > /tmp/pkg_kadai3.log 2>&1
sleep 2
cat /tmp/pkg_kadai.log | grep 'player3>> torst' || ng "$LINENO"
cat /tmp/pkg_kadai2.log | grep 'player1>> taste' || ng "$LINENO"
cat /tmp/pkg_kadai3.log | grep 'player2>> test' || ng "$LINENO"
cat /tmp/pkg_kadai.log
cat /tmp/pkg_kadai2.log
cat /tmp/pkg_kadai3.log
echo OK
exit $res