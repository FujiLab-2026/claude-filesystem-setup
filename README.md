# claude-filesystem-setup

Claude Desktop に Filesystem MCPサーバーを追加するセットアップツールです。

Filesystem MCPサーバーを入れると、Claude が自分のPC上のファイル（PDF・Excel・テキストなど）を直接読み書きできるようになります。

## 前提条件

- **Claude Desktop** がインストール済み
- **Node.js**
  入っていない場合は https://nodejs.org/en/download からインストールしてください。
  - Windows: 「Windows Installer (.msi)」の 64-bit をダウンロード → ダブルクリック → 全て「Next」→「Install」でOK
  - macOS: 「macOS Installer (.pkg)」をダウンロード → ダブルクリック → 全て「続ける」→「インストール」でOK

## セットアップ手順

### Step 1: ダウンロード

1. https://github.com/FujiLab-2026/claude-filesystem-setup を開く
2. 緑色の **「Code」** ボタンをクリック → **「Download ZIP」** をクリック
3. ダウンロードされた ZIP を展開する

> うまくいかない場合は直接ダウンロード: https://github.com/FujiLab-2026/claude-filesystem-setup/archive/refs/heads/main.zip

### Step 2: セットアップ実行

展開したフォルダの中にあるファイルをダブルクリックしてください。

- **Windows**: `setup_windows.bat` をダブルクリック
- **macOS**: `setup_macos.command` をダブルクリック

> **macOS で「開発元が未確認」と表示された場合**: `setup_macos.command` を右クリック →「開く」→「開く」をクリックしてください。

画面に「セットアップ完了！」と表示されればOKです。

### Step 3: Claude Desktop を再起動

- **Windows**: タスクバー右下の Claude アイコンを右クリック →「終了」してから再度開く
- **macOS**: メニューバーの Claude →「Quit Claude」してから再度開く

### Step 4: 動作確認

Claude に **「Documents フォルダの中身を見せて」** と話しかけてください。
ファイル一覧が表示されれば成功です。

## トラブルシューティング

- **「Node.js がインストールされていません」と表示される**: Node.js をインストールしてからもう一度スクリプトを実行してください
- **サーバーが表示されない**: Claude Desktop を再起動したか確認してください
- **初回起動が遅い**: 初回は必要なファイルをダウンロードするため時間がかかります（2回目以降は速いです）
- **macOS で「開発元が未確認」**: ファイルを右クリック →「開く」で実行できます

## 備考

- デフォルトでは Documents フォルダにアクセスできます
- 他のフォルダも追加したい場合は藤井に相談してください
- このセットアップは既存の Claude Desktop 設定を壊しません（filesystem の設定のみ追加されます）

## 開発者

藤井武宏（三重大学医学部附属病院 肝胆膵・移植外科 / 医療情報管理部）
