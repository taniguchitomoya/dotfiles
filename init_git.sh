#gitの設定
git config --global user.name "Tomoya Taniguchi"
git config --global user.email "github@taniguchitomoya.com"

ssh-keygen -t ed25519 \
  -C "github@taniguchitomoya.com" \
  -f ~/.ssh/id_ed25519 \
  -N ""

#.ssh/id_ed25519.pubの内容をGitHubのSSHキーに登録する
cat ~/.ssh/id_ed25519.pub

#登録後
#ssh -T git@github.com
#yes1回必要

#clone時はSSH URLを使う
#git clone git@github.com:username/repo.git
