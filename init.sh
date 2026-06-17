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

is_wsl() {
    grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null
}

if is_wsl; then
    echo "WSL環境を検出しました。wsl.confのセットアップを開始します..."

    SRC_CONF="./config/wsl.conf"
    DEST_CONF="/etc/wsl.conf"

    # 既にファイルが存在する場合はバックアップを取る（安全対策）
    if [ -f "$DEST_CONF" ]; then
        echo "既存の wsl.conf をバックアップします -> ${DEST_CONF}.bak"
        sudo cp "$DEST_CONF" "${DEST_CONF}.bak"
    fi

    # ファイルをコピーして権限を適切に設定
    sudo cp "$SRC_CONF" "$DEST_CONF"
    sudo chown root:root "$DEST_CONF"
    sudo chmod 644 "$DEST_CONF"

    echo "✅ wsl.conf の配置が完了しました。"
    echo "⚠️ 変更を適用するには、WindowsのPowerShellで 'wsl --shutdown' を実行してWSLを再起動してください。"
else
    echo "WSL環境ではないため、wsl.conf のセットアップをスキップします。"
fi
