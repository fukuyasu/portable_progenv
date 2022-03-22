# portable_progenv
Recipe of portable programming environment

GCC
- MinGW-w64: https://sourceforge.net/projects/mingw-w64/files/

## バージョン番号
X.YpZ
- X: メジャーバージョン（ディレクトリ構成の変更，CLI環境の設定変更など）
- Y: マイナーバージョン（GCCのメジャーバージョンの変更）
- Z: パッチレベル（上記以外の更新）

リリース
| バージョン | リリース日 | GCC |
|:----|:-----------|:------|
| 1.0 | 2022/03/xx | 8.1.0 |

## ディレクトリ構成
```
portable_progenv
   +-- Makefile         （構築スクリプト本体，CLI環境）
   +-- mingw.mk         （MinGW-w64用構築スクリプト）
   +-- clinit.src       （clinit.batのソース，CLI環境の初期化）
   +-- clinit-mingw.src （clinit.batから読み込まれるスクリプトのソース）
   +-- progenv command-line.lnk  （CLI環境へのリンク）
   +-- progenv          （環境出力用ディレクトリ）
distfiles    （ダウンロードファイル - 構築スクリプトから使用）
   +-- x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z
release
   +-- progenv-X.YpZ.yyyymmdd.zip
```

## How to make
```
$ make zip-all
```

## How to install
`progenv-X.YpZ.yyyymmdd.zip`をCドライブの直下（C:\）に展開する
- 7-Zipで展開できることを確認済み（2022/03/22）

## 展開後のディレクトリ構成
```
progenv
   +-- mingw64 （MinGW-w64を展開したディレクトリ）
   +-- work    （CLI環境のホームディレクトリ）
   +-- progenv command-line.lnk （cmd.exeへのショートカット）
   +-- clinit.bat       （cmd.exeの環境を初期化するスクリプト）
   +-- clinit-mingw.bat （clinit.batから読み込まれるスクリプト，MinGW-w64のPath設定）
```
