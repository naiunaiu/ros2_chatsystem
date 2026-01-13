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
mv src/pkg_kadai3/pkg_kadai3/player1.py src/pkg_kadai3/pkg_kadai3/player3.py
ls /root/ros2_ws/src/pkg_kadai2
ls /root/ros2_ws/src/pkg_kadai3
sed -i "s@'player1 = pkg_kadai.player1:main',@'player2 = pkg_kadai2.player2:main',@g" /root/ros2_ws/src/pkg_kadai2/setup.py
sed -i "s@'player1 = pkg_kadai.player1:main',@'player3 = pkg_kadai3.player3:main',@g" /root/ros2_ws/src/pkg_kadai3/setup.py
cd /root/ros2_ws
colcon build
source install/setup.bash

expect -c "
  spawn ros2 run pkg_kadai player1
  expect \"No connection with partner \"
  sleep 1
  send \"taste\r\"
  sleep 2
  send \"/exit\r\"
" > /tmp/pkg_kadai.log 2>&1

cat /tmp/pkg_kadai.log | grep 'player1> torst' || ng "$LINENO"
cat /tmp/pkg_kadai.log | grep 'No connection with partner' || ng "$LINENO"
cat /tmp/pkg_kadai.log
echo OK
exit $res