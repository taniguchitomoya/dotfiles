# AIへの開発指示書 (INSTRUCTION_FOR_AI.md)

このドキュメントは、別のAIアシスタントに対して、本リポジトリ（WSL2初期セットアップ用スクリプト集）と同等のプログラム群をゼロから作成させるための指示書です。

---

## 📋 プロジェクトの目的
新規にインストールされた WSL2 (Ubuntu) 環境において、パッケージのアップデートから開発ツールの導入（mise、Node.js、Python、Claude Code、AWS CLI）およびシステム設定（wsl.conf）までを自動・半自動で実行するシェルスクリプト群を作成する。

---

## 🛠️ 作成すべきファイルと要件

### 1. `init.sh` (システム初期設定スクリプト)
WSL2インストール直後のUbuntuで最初に実行するスクリプト。
- **要件**:
  - `apt update` および `apt upgrade` を実行してシステムを最新にする。
  - バージョン管理ツール `mise` (https://mise.run) をインストールする。
  - `~/.bashrc` に `mise` の実行パスとフック設定 (`eval "$(mise activate bash)"`) を追記する。
  - テスト用のディレクトリを作成して移動し、`mise use python@lts` および `mise use node@lts` を実行してLTSバージョンをインストール・設定する。
  - WSL環境であるかを判定する関数（`/proc/version` に `Microsoft` または `WSL` が含まれるか）を実装する。
  - WSL環境の場合、リポジトリ内の `config/wsl.conf` を `/etc/wsl.conf` にコピーする。すでに存在する場合は `wsl.conf.bak` に退避させ、コピー後のファイルの所有者を `root:root`、パーミッションを `644` に設定する。

### 2. `config/wsl.conf` (WSL設定ファイル)
WSL2のシステム挙動をカスタマイズする設定ファイル。
- **要件**:
  - `[boot]` セクションで `systemd=true` を有効にする。
  - `[automount]` セクションで `enabled = false` とする。
  - `[interop]` セクションで `enabled = false` および `appendWindowsPath = false` とする。

### 3. `init_git.sh` (Git設定スクリプト)
Gitの基本設定とGitHub接続用のSSHキーを作成するスクリプト。
- **要件**:
  - グローバルの `user.name` と `user.email` を設定する（デフォルト値を入れておき、ユーザーが書き換え可能にする）。
  - `ed25519` 方式でパスフレーズ無しのSSHキーを `~/.ssh/id_ed25519` に生成する。
  - 生成後、GitHubに登録しやすいように `~/.ssh/id_ed25519.pub` の内容を `cat` でターミナルに出力する。

### 4. `init_claude_code.sh` (Claude Code設定スクリプト)
CLIでのAI開発ツールである Claude Code をセットアップする。
- **要件**:
  - `npm install -g @anthropic-ai/claude-code` を実行してグローバルにインストールする。
  - 初回起動の確認用にホームディレクトリ配下にテスト用ディレクトリを作成し、そこで `claude` コマンドを実行する。

### 5. `install_awscli.sh` (AWS CLIインストールスクリプト)
AWS CLI v2 をインストールするスクリプト。
- **要件**:
  - 公式のLinux用zipパッケージ (`https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip`) を `curl` でダウンロードする。
  - zipを展開し、`sudo ./aws/install` を実行してインストールする。
  - インストール完了後、ダウンロードしたzipおよび展開された `aws` ディレクトリを削除してクリーンアップする。

---

## 💡 実装上の注意点
- スクリプトは Bash (`#!/bin/bash` または `#!/bin/sh`) で動作するようにし、適宜コメントで処理内容を日本語で説明すること。
- 必要に応じて、エラーハンドリングや実行権限の付与手順などを記述すること。
- 機密情報やユーザー個別の設定項目（Gitのメールアドレス等）は、簡単に書き換えられるよう設計すること。
