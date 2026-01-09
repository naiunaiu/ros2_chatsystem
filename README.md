# robosys2025

## ros2チャットシステム
![test](https://github.com/naiunaiu/robosys2025/actions/workflows/test.yml/badge.svg)

複数端末間でチャットが出来るros2パッケージ。

## 使い方

- コマンド
    ```
    # 実行ファイル名は初期状態だとplayer1、player2

    $ ros2 run pkg_kadai {実行ファイル名}
    ```
## 機能
- 実行ファイル名を変えることで、送信時に表示される名前を変更可能。

- 相手の接続が確認できない場合、接続不可のエラーを表示。

- 複数端末間での通信が可能。
## 構造
- 建てられるノード
  - bun2_node_<実行ファイル名>
  メッセージを受け取り、送信するノード。実行ファイルの名前によって名前が変化する。

- 作られるトピック
  - top_pub
  入力したメッセージを送るトピック。
  - top_stat
  ステータスを送信するトピック。このトピックから何か受信すれば、通信を確立できたことになる。


## 使用例
```
terminal_1:$ ros2 run pkg_kadai player1
player1>

No connection with partner #通信相手がいないとこれが表示される

player2>> メッセージ
player1> テスト

---以下別端末---

#別のターミナルでもう一方のノードを立ち上げる
terminal_2:$ ros2 run pkg_kadai2 player2
player2> メッセージ
player1>> テスト
```

## 必要なソフトウェア
- Python
  - python 3.10で検証済み

## テスト環境
  - Ubuntu 24.04 LTS
  - python 3.10

## ライセンス
- このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
- © 2025 Satoh Narumi