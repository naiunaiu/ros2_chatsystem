# robosys2025

## ros2チャットシステム
![test](https://github.com/naiunaiu/robosys2025/actions/workflows/test.yml/badge.svg)

2つのデバイス間でチャットが出来るros2パッケージ。

## 使い方

- コマンド
    ```
    ros2 run pkg_kadai player1
    ```
+ モード変更オプションと対応する値入力オプション
  - `reso` :画像の解像度を変更する。
  
    - 値入力オプション: `1~100`の、画像のクオリティを指定する整数値。
  - `size`  :画像の縦横の長さを変更する。
  
    - 値入力オプション: `<縦長さ> x <横長さ>`を表す2つの整数値を入力する
  - `get` :画像の縦横の長さとサイズを表示する
  
    - 値入力オプション: なし
  - `-util` :このオプションの後に`info`、`debug`のどちらかを入力して使用する
    
    - `info`: 変更された値を、変更前の値と単位をつけて出力する。
    - `debug`: 変更された要素がカンマ区切りされて出力される。別のプログラムへのデータの受け渡しに。

## 使用例
```
#image.jpgの解像度を半分くらい下げたい場合
$gazo reso image.jpg 50

#image.jpgの縦横の長さをを200x200にしたい場合
$ gazo size /home/image.jpg 200 200

#image.jpgのサイズと縦横の長さを知りたい場合
$ gazo size /home/image.jpg
size_of_file:(hoge)x(huga) 
bite_of_file:(hoge)KB

#拡張オプションを使いたい場合。 モードはresoで実行
$ gazo reso /home/image.jpg 50 -util info
bite_of_file:(hoge)KB>(huga)KB
```
## インストール方法
```
git clone https://github.com/naiunaiu/gazo.git
```

## 必要なソフトウェア
- Python
  - Python 3.7~3.10で検証済み

## テスト環境
  - Ubuntu 24.04 LTS

## ライセンス
- このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
- © 2025 Satoh Narumi