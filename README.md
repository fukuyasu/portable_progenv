# portable_progenv
Recipe of portable programming environment

GCC
- MinGW-w64: https://github.com/niXman/mingw-builds-binaries/releases

JDK
- Adoptium OpenJDK: https://adoptium.net/

Eclipse/Pleiades
- Eclipse: https://www.eclipse.org/downloads/packages/
- Pleiades: https://willbrains.jp/

Git for Windows
- Git: https://git-scm.com/
- Git for Windows: https://github.com/git-for-windows/git/releases/

## バージョン番号
X.YpZ
- X: メジャーバージョン（ディレクトリ構成の変更，CLI環境の設定変更など）
- Y: マイナーバージョン（GCC/JDKのメジャーバージョンの変更）
- Z: パッチレベル（上記以外の更新）

リリース
| バージョン | リリース日 | GCC | JDK | Eclipse | Pleiades | Git for Windows |
|:----|:-----------|:------|:---------|:----------|:-----------|:---------|
| 4.1-rc2 | 2025/04/08 | 14.2.0 | 21.0.6+7 | 2025-03 R | 2025.06.20 | 2.49.0 |
| 4.0.2 | 2024/04/11 | 8.1.0 | 17.0.10+7 | 2024-03 R | 2024.03.25 | 2.44.0 |
| 4.0.1 | 2023/04/11 | 8.1.0 | 17.0.6+10 | 2023-03 R | 2023.03.15 | 2.40.0 |
| 4.0 | 2022/04/12 | 8.1.0 | 17.0.2+8 | 2022-03 R | 2022.03.26 | 2.35.1.2 |

## ディレクトリ構成
```
portable_progenv/
   +-- Makefile            （構築ルール本体，CLI環境）
   +-- ##-xxxxx.mk         （Makefileから読み込まれるサブ環境構築ルール）
   +-- clinit.src          （clinit.batのソース，CLI環境の初期化）
   +-- clinit-##-xxxxx.src （clinit.batから読み込まれるスクリプトのソース）
   +-- eclipseconf.sh      （Eclipse用設定スクリプト）
   +-- progenv command-line.lnk  （CLI環境へのリンク）
   +-- progenv/            （環境出力用ディレクトリ）
   +-- tmp/                （作業用ディレクトリ）
distfiles/    （ダウンロードファイル - 構築ルールから使用）
   +-- x86_64-X.Y.Z-release-win32-seh-ucrt-rt_vV-revR.7z
   +-- OpenJDKXU-jdk_x64_windows_hotspot_X.Y.Z_W.zip
   +-- eclipse-java-yyyy-mm-R-win32-x86_64.zip
   +-- pleiades-win-yyyy.mm.dd.zip
   +-- MinGit-X.Y.Z-busybox-64-bit.zip
release/
   +-- progenv-X.YpZ.yyyymmdd.zip
   +-- progenv-X.YpZ-xxxxx.yyyymmdd.zip
```

## How to make
```
$ make progenv-zip-all
```

## How to install
`progenv-X.YpZ.yyyymmdd.zip`をCドライブの直下（C:\）に展開する
- 7-Zipで展開できることを確認済み（2022/03/22）

## 展開後のディレクトリ構成
```
progenv
   +-- mingw64   （MinGW-w64を展開したディレクトリ）
   +-- java/${JAVA_MAJOR} （JDKを展開したディレクトリ）
   +-- eclipse   （Eclipse+Pleiadesを展開したディレクトリ）
   +-- MinGit    （MinGitを展開したディレクトリ）
   +-- work      （CLI環境のホームディレクトリ）
   +-- workspace （Eclipse用ワークスペース）
   +-- progenv command-line.lnk （cmd.exeへのショートカット）
   +-- clinit.bat          （cmd.exeの環境を初期化するスクリプト）
   +-- clinit-10-mingw.bat （clinit.batから読み込まれるスクリプト，MinGW-w64のPath設定）
   +-- clinit-20-java.bat  （clinit.batから読み込まれるスクリプト，JDKのPath設定）
   +-- clinit-70-git.bat   （clinit.batから読み込まれるスクリプト，MinGitのPath設定）
```
