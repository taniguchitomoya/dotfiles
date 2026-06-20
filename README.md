# dotfiles

WSL2 (Ubuntu) のインストール直後に行う初期セットアップを自動化・半自動化するためのスクリプト集です。

> [!NOTE]
> 本プロジェクトのスクリプトおよびドキュメントは、AI（Google Antigravity / Gemini）の支援を受けて作成・更新されています。

---

## 🚀 含まれるスクリプトと機能

| スクリプト名 | 概要 | 主な処理内容 |
| :--- | :--- | :--- |
| [`init.sh`](file:///home/tomoya/dotfiles/init.sh) | システム初期化 & 基本ツールの導入 | `apt update/upgrade`、`mise` のインストール、Python/Node.js のLTS導入、`wsl.conf` の配置 |
| [`init_git.sh`](file:///home/tomoya/dotfiles/init_git.sh) | Git初期設定 & SSHキー生成 | `git config` 設定、SSHキー (`ed25519`) 作成と公開キーの出力 |
| [`init_claude_code.sh`](file:///home/tomoya/dotfiles/init_claude_code.sh) | Claude Code のセットアップ | `@anthropic-ai/claude-code` のグローバルインストールとテスト起動 |
| [`install_awscli.sh`](file:///home/tomoya/dotfiles/install_awscli.sh) | AWS CLI のセットアップ | AWS CLI v2 のダウンロード、インストール、およびクリーンアップ |

---

## 🛠️ 使い方と実行手順

### 1. リポジトリのクローンと移動
```bash
git clone git@github.com:taniguchitomoya/dotfiles.git
cd dotfiles
```

### 2. システムの初期設定と開発環境構築 (`init.sh`)
WSL2のUbuntuインストール直後に実行します。

```bash
chmod +x init.sh
./init.sh
```

> [!IMPORTANT]
> `init.sh` 実行により `/etc/wsl.conf` が配置されます。設定を有効にするには、WindowsのPowerShellで以下のコマンドを実行し、WSLを再起動してください。
> ```powershell
> wsl --shutdown
> ```

### 3. Gitの設定とSSH接続設定 (`init_git.sh`)
Gitのコミッター情報の設定と、GitHub接続用のSSHキーを作成します。

> [!WARNING]
> スクリプトを実行する前に、[`init_git.sh`](file:///home/tomoya/dotfiles/init_git.sh) 内の `user.name` と `user.email` をご自身の情報に書き換えてください。

```bash
chmod +x init_git.sh
./init_git.sh
```
実行後、ターミナルに出力された公開鍵（`~/.ssh/id_ed25519.pub` の内容）をコピーし、[GitHubのSSH Keys設定](https://github.com/settings/keys)に登録してください。

### 4. Claude Code の導入 (`init_claude_code.sh`)
CLI向けAIコーディングツール「Claude Code」を導入します。

```bash
chmod +x init_claude_code.sh
./init_claude_code.sh
```

### 5. AWS CLI のインストール (`install_awscli.sh`)
AWSの操作に必要な AWS CLI v2 をインストールします。

```bash
chmod +x install_awscli.sh
./install_awscli.sh
```

---

## ⚙️ 各種設定ファイル

- **[`config/wsl.conf`](file:///home/tomoya/dotfiles/config/wsl.conf)**: systemd の有効化、Windows側 PATH の自動追加無効化などを定義しています。

## 📝 開発ガイドライン

- **AIコーディングのルール**: 詳細な運用ルールは [`.ai-instructions.md`](file:///home/tomoya/dotfiles/.ai-instructions.md) を参照してください。
