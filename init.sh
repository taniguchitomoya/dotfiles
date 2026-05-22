#初期設定コマンド
#WSL2のubuntu（インストール直後の状態）にて使う
#2026/5/14 新規作成

sudo apt update
sudo apt upgrade

#miseのインストール
curl https://mise.run | sh

echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

#シェルへのフックの設定みたいなやつ
#一時的に使う場合#eval "$(mise activate bash)"
echo 'eval "$(mise activate bash)"' >> ~/.bashrc

source ~/.bashrc


mkdir test
cd test

#カレントディレクトリの設定をする
mise init
mise use python@lts
mise use node@lts

#自分で.mise.tomlを書いた場合などに明示的にインストールさせる場合
mise install


#VS Code
code .
#WSL 拡張をインストール



#他に追加検討
#VS Codeの拡張機能のインストール

#miseの設定はコマンドじゃなくてrepoに置くべき？

