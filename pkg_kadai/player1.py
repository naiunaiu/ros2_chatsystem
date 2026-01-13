#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Satoh-Narumi
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
import os
import sys
from rclpy.node import Node
from std_msgs.msg import String
import threading


myname = os.path.basename(__file__)
rclpy.init()
node = Node("bun2_node" + myname.replace(".py", ""))    
pub_msg = node.create_publisher(String, "top_pub", 10)
pub_status = node.create_publisher(String, "top_stat", 10)
Is_someone_active = False
Death = False

def callduck(msg = String()):
    name, message = msg.data.split(">>", 1)
    if myname.replace(".py", "") in name or message == " ":
        return
    else:
        print(f"\r{msg.data}\n{myname.replace('.py', '')}>", end="")
    if Death:
        pass
    
#ステータス受信時trueにする
def cellback(status = String()):
    global Is_someone_active
    if myname in status.data:
        return
    else:
        Is_someone_active = True  
    if Death:
        pass
    
#ステータス確認用
def statusback():
    global Is_someone_active
    if Is_someone_active:
        Is_someone_active = False
    else:
        sys.stderr.write("No connection with partner.\n")
    stat = String()
    stat.data = myname
    pub_status.publish(stat)
    if Death:
        pass
    
    
def main():
    thread_status = threading.Thread(target=lambda: rclpy.spin(node), daemon=True) 
    node.create_timer(1, statusback)    
    node.create_subscription(String, "top_pub", callduck, 10)
    node.create_subscription(String, "top_stat",cellback,10)
    
    #すれど２,３
    thread_status.start()
    
    #すれど１
    try:
        while rclpy.ok():
            sys.stdout.write(myname.replace(".py", "") + "> ", end="")
            sys.stdout.flush()
            try:
                keyinput = input()
            except EOFError:
                break
        
            msg = String()
            if "/exit" in keyinput:
                if rclpy.ok():
                    pass
            else:
                msg.data = myname.replace(".py", "") + ">> " + keyinput
                pub_msg.publish(msg)      
    except KeyboardInterrupt:
        pass
    finally:
        if rclpy.ok():
            global Death
            Death = True
            node.destroy_node()
            rclpy.shutdown()
            thread_status.join()
            sys.exit(0)