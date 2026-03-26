#!/bin/bash
# ============================================
#  Filesystem MCP サーバー セットアップ (macOS)
# ============================================

# .command ファイルはダブルクリックで開いたとき、
# ファイルのある場所ではなくホームで起動するので移動
cd "$(dirname "$0")"

echo "============================================"
echo " Filesystem MCP サーバー セットアップ"
echo "============================================"
echo ""

# Node.js チェック
if ! command -v npx &>/dev/null; then
    echo "[エラー] Node.js がインストールされていません。"
    echo ""
    echo "先に Node.js をインストールしてください:"
    echo "https://nodejs.org/en/download"
    echo ""
    echo "「macOS Installer (.pkg)」をダウンロードして実行してください。"
    echo "インストール後、このスクリプトをもう一度実行してください。"
    echo ""
    read -p "Enter キーで閉じます..."
    exit 1
fi

echo "[OK] Node.js が見つかりました"
echo ""

# 設定ファイルのパス
CONFIG_DIR="$HOME/Library/Application Support/Claude"
CONFIG_FILE="$CONFIG_DIR/claude_desktop_config.json"
DOCS_PATH="$HOME/Documents"

# ディレクトリ作成
mkdir -p "$CONFIG_DIR"

# Node.js で JSON を安全に更新（Node.js は前提条件なので使える）
node -e "
const fs = require('fs');
const path = process.argv[1];
const docsPath = process.argv[2];

let config = {};
try {
    config = JSON.parse(fs.readFileSync(path, 'utf8'));
} catch (e) {
    // ファイルが無い or 不正な JSON → 新規作成
}

if (!config.mcpServers) {
    config.mcpServers = {};
}

config.mcpServers.filesystem = {
    command: 'npx',
    args: ['-y', '@modelcontextprotocol/server-filesystem', docsPath]
};

fs.writeFileSync(path, JSON.stringify(config, null, 2));
console.log('[OK] 設定ファイルを更新しました: ' + path);
console.log('[OK] アクセス許可フォルダ: ' + docsPath);
" "$CONFIG_FILE" "$DOCS_PATH"

if [ $? -ne 0 ]; then
    echo ""
    echo "[エラー] 設定ファイルの更新に失敗しました。"
    echo "藤井に連絡してください。"
    read -p "Enter キーで閉じます..."
    exit 1
fi

echo ""
echo "============================================"
echo " セットアップ完了！"
echo "============================================"
echo ""
echo "Claude Desktop を再起動してください:"
echo "  メニューバーの Claude → 「Quit Claude」 → 再度開く"
echo ""
echo "再起動後、Claude に「Documents フォルダの中身を見せて」と"
echo "話しかけて動作確認してください。"
echo ""
read -p "Enter キーで閉じます..."
