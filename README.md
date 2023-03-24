# portable_progenv
Recipe of portable programming environment

GCC
- MinGW-w64: https://sourceforge.net/projects/mingw-w64/files/

JDK
- Adoptium OpenJDK: https://adoptium.net/
- AdoptOpenJDK: https://adoptopenjdk.net/ (has moved to adoptium.net)

Eclipse/Pleiades
- Eclipse: https://www.eclipse.org/downloads/packages/
- Pleiades: https://mergedoc.osdn.jp/

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
| 4.0 | 2022/04/12 | 8.1.0 | 17.0.2_8 | 2022-03 R | 2022.03.26 | 2.35.1.2 |
| 4.0.1-rc1 | 2023/03/24 | 8.1.0 | 17.0.6_10 | 2023-03 R | 2023.03.15 | 2.40.0 |

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
   +-- x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z
   +-- OpenJDK17U-jdk_x64_windows_hotspot_17.0.6_10.zip
   +-- eclipse-java-2023-03-R-win32-x86_64.zip
   +-- pleiades-win-2023.03.15.zip
   +-- MinGit-2.40.0-busybox-64-bit.zip
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
