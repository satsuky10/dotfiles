# dotfiles

個人用の設定ファイル管理リポジトリ。

## 含まれる設定

- **WezTerm** - ターミナルエミュレータの設定（UI、キーバインド）
- **Brewfile** - Homebrew でインストールするパッケージの管理
- **Hammerspoon** - Ctrl ダブルタップで WezTerm の表示/非表示を切り替え

## セットアップ

```bash
git clone git@github.com:satsuky10/dotfiles.git
cd dotfiles
./install.sh
```

`install.sh` は既存ファイルがあれば `.bak` にバックアップしてからシンボリックリンクを作成します。既にリンク済みの場合はスキップします。

## Homebrew パッケージの管理

`install.sh` により `~/Brewfile` にシンボリックリンクが作成されるため、`brew bundle` は `--global` オプションで実行できます。

### 新しいパッケージを追加する

1. `Brewfile` にパッケージを追記する
   - CLI ツール: `brew "パッケージ名"`
   - GUI アプリ: `cask "パッケージ名"`
   - サードパーティ tap: `tap "tap名"`
2. インストールを実行する
   ```bash
   brew bundle --global
   ```

### Brewfile の内容を一括インストールする（新しい Mac のセットアップ時など）

```bash
brew bundle --global
```

### 不要なパッケージを削除する

1. `Brewfile` から該当行を削除する
2. Brewfile に記載のないパッケージをアンインストールする
   ```bash
   brew bundle cleanup --global --force
   ```

> **注意:** `brew uninstall "パッケージ名"` で手動アンインストールした場合、`Brewfile` からも該当行を削除してください。残っていると次回 `brew bundle --global` 実行時に再インストールされます。
