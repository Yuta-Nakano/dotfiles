# dotfiles

https://techracho.bpsinc.jp/hachi8833/2019_06_06/66396
https://qiita.com/magicant/items/d3bb7ea1192e63fba850

# ~/.profile

- **ログイン時**にそのセッション全体に適用するものを記述する
- **シェルの種類に依存しない**ものを記述する

- bash/zsh に依存しないもの**だけ**を書く
- GUI アプリで使うものや bin/sh で使うものは**ここに置く（必須）**
- ログインシェルで使うものはここに置くべき

**ex**<br>

- 環境変数
- `PATH` 変数

# ~/.bashrc, ~/.zshrc

- **bash/zsh でしか使わないもの**を記述する
- 対話モードで使うものはすべてここに書く
- ここでは**何も出力してはならない**

**ex**<br>

- エイリアス
- `EDITOR` 変数
- プロンプト設定
- シェルオプション

# ~/.bash_profile, ~/.zprofile

- `~/.profile` と同じに使えるが、**bash/zsh のみで有効**
- 余計なものは極力書かない
- 右の順に読み込むだけにする

**ex**<br>

- `~/.profile` があれば読み込む
- `~/.bashrc`, `~/.zshrc` があれば読み込む

# ~/.bash_login

- 使わない

# 読み込まれる順番

https://qiita.com/hirokishirai/items/5a529c8395c4b336bf31
