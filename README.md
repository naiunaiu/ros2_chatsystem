# robosys2025

## ros2チャットシステム
![test](https://github.com/naiunaiu/robosys2025/actions/workflows/test.yml/badge.svg)

2つのデバイス間でチャットが出来るros2パッケージ。

## 使い方

- コマンド
    ```
    # 実行ファイル名は初期状態だとplayer1、player2

    $ ros2 run pkg_kadai {実行ファイル名}
    ```


## 使用例
```
terminal_1:$ ros2 run pkg_kadai player1
player1>
No connection with partner #通信相手がいないとこれが表示される
player2>>メッセージ
player1>テスト

---以下別端末での使用例---

#別のターミナルでもう一方のノードを立ち上げる
terminal_2:$ ros2 run pkg_kadai player2
player2>メッセージ
player1>>テスト
```

## 必要なソフトウェア
- Python
  - Python 3.7~3.10で検証済み

## テスト環境
  - Ubuntu 24.04 LTS

## ライセンス
- このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
- © 2025 Satoh Narumi