#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Satoh-Narumi
# SPDX-License-Identifier: BSD-3-Clause

import sys
import os
import fcntl
import time
import subprocess

#非ブロッキング処理？
def non_blocking(file):
    fd = file.fileno()
    flags = fcntl.fcntl(fd, fcntl.F_GETFL)
    fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)

player1 = subprocess.Popen(["ros2", "run", "pkg_kadai", "player1"],
                     stdin=subprocess.PIPE,
                     stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE,
                     text=True
                     )
time.sleep(1)
player2 = subprocess.Popen(["ros2", "run", "pkg_kadai", "player2"],
                     stdin=subprocess.PIPE,
                     stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE,
                     text=True
                     )

non_blocking(player1.stdout)
non_blocking(player1.stderr)
non_blocking(player2.stdout)

def requester(input):
    player1.stdin.write(input + "\n")
    player1.stdin.flush()
    
def reader():
    time.sleep(1)
    try:
        return player2.stdout.read()
    except:
        return ""
def main():
    
    try:
        time.sleep(2)
    
        text = "aaiiuueeoo"
        requester(text)
        readed_text = reader()
                
        if text in readed_text:
            print("1おｋ")
        else:
            sys.exit("1ダメ")
            
        if text in readed_text:
            print("2おｋ")
        else:
            sys.exit("2ダメ")
            
    except subprocess.TimeoutExpired:
        player1.kill()
        player2.kill()
        print("Timeout!!")
    except Exception as e:
        player1.kill()
        player2.kill()
        print(f"error: {e}")
        
    #以下例外処理
    
    #片方だけ起動して相手が存在しないエラーを吐くか
    errormsg = "No connection with partner"
    
    output = player1.stdout.read() 
    error = player1.stderr.read() 
    all_output = output + error
        
    if errormsg in all_output:
        print("ステータス:ok")
    else:
        sys.exit("status chech failed")
            
    
    print("おわり")
    player1.kill
    player2.kill
main()
    