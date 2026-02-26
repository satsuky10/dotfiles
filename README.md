# dotfiles

個人用の設定ファイル管理リポジトリ。

## 含まれる設定

- **WezTerm** - ターミナルエミュレータの設定（UI、キーバインド）

## セットアップ

```bash
git clone git@github.com:satsuky10/dotfiles.git
cd dotfiles
./install.sh
```

`install.sh` は既存ファイルがあれば `.bak` にバックアップしてからシンボリックリンクを作成します。既にリンク済みの場合はスキップします。
