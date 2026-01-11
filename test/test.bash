#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 Satoh-Narumi
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws

echo 'taste' | timeout 10 ros2 launch pkg_kadai player1 > /tmp/pkg_kadai.log
cat /tmp/pkg_kadai.log | grep 'player1:taste'