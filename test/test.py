#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Satoh-Narumi
# SPDX-License-Identifier: BSD-3-Clause

import os
import sys
import time
import subprocess

player1 = subprocess.popen(["ros2", "run", "pkg_kadai", "player1"],
                     stdin=subprocess.PIPE,
                     stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE,
                     text=True
                     )
time.sleep(1)
player2 = subprocess.popen(["ros2", "run", "pkg_kadai", "player2"],
                     stdin=subprocess.PIPE,
                     stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE,
                     text=True
                     )

def text_inserter(input_text):
    stdout, stderror = player1.communicate(input=input_text, timeout=10)
    return stdout, stderror
    
def main():
    
    pub = text_inserter()
    
    try:
        time.sleep(2)
    
        out_1, error_1 = text_inserter("aaa")[0]
        out_2, error_2 = text_inserter("iii")[1]
        
        if "aaa" in out_1:
            print("1おｋ")
        else:
            sys.exit("1ダメ")
            
        if "iii" in out_2:
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
    out_1_a, error_1_a = text_inserter("a")
    
    if error_1_a[1] in "No connection with partner":
        print("ok")
    else:
        sys.exit("Status check error")
    
    
main()
    