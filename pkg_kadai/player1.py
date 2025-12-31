#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Satoh-Narumi
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
import os
import sys
import time
import string
from rclpy.node import Node
from std_msgs.msg import Int16
from std_msgs.msg import String
import threading

myname = os.path.basename(__file__)
rclpy.init()
node = Node("bun2_node_" + myname.replace(".py", ""))    
pub_msg = node.create_publisher(String, "top_pub", 10)
pub_status = node.create_publisher(Int16, "top_stat", 10)
Is_partner_active = False
actived = False
status_data = ""

def callduck(msg):
    sys.stdout.write(f"\r{msg.data}\nplayer1> ")
    sys.stdout.flush()
    
#ステータス受信時trueにする
def cellback(status):
    global Is_partner_active, status_data
    Is_partner_active = True
    status_data = status.data   

#ステータス確認用
def statusback():
    global Is_partner_active, actived
    n = 1
    if Is_partner_active:
        Is_partner_active = False
    else:
        sys.stderr.write("\nNo connection with partner.\n")
    stat = Int16()
    stat.data = n
    pub_status.publish(stat)
    
    
def main():
    thread_status = threading.Thread(target=lambda: rclpy.spin(node), daemon=True) 
    node.create_timer(1, statusback)    
    node.create_subscription(String, "top_sub", callduck, 10)
    node.create_subscription(Int16, "top_tats",cellback,10)
    
    #すれど２,３
    thread_status.start()
    
    #すれど１
    try:
        while rclpy.ok():
            print(myname.replace(".py", "") + "> ", end="", flush=True)
            keyinput = input()
            msg = String()
            msg.data = myname.replace(".py", "") + ">>" + keyinput
            pub_msg.publish(msg)
            
    except KeyboardInterrupt:
        pass
    except EOFError:
        keyinput = " "
    
    node.destroy_node()