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
sudo apt-get install -y expect
cd /root/ros2_ws
mv src/pkg_kadai2/pkg_kadai2/player1.py src/pkg_kadai2/pkg_kadai2/player2.py
ls /root/ros2_ws/src/pkg_kadai2
sed -i "s@'player1 = pkg_kadai.player1:main',@'player2 = pkg_kadai2.player2:main',@g" /root/ros2_ws/src/pkg_kadai2/setup.py
cd /root/ros2_ws
colcon build
source install/setup.bash

expect -c "
  spawn ros2 run pkg_kadai player1
  sleep 9
  send \"taste\r\"
  sleep 2
  send \"/exit\r\"
" > /tmp/pkg_kadai.log 2>&1
expect -c "
  spawn ros2 run pkg_kadai2 player2
  sleep 9
  expect \"player2> \"
  send \"test\r\"
  sleep 2
  send \"/exit\r\"
" > /tmp/pkg_kadai2.log 2>&1

cat /tmp/pkg_kadai.log | grep 'player2>> test' || ng "$LINENO"
cat /tmp/pkg_kadai2.log | grep 'player1>> taste' || ng "$LINENO"
cat /tmp/pkg_kadai.log | grep 'No connection with partner' || ng "$LINENO"
cat /tmp/pkg_kadai.log
cat /tmp/pkg_kadai2.log
echo OK
exit $res