@echo off
chcp 65001 >nul 2>nul
echo ============================================
echo  Filesystem MCP サーバー セットアップ
echo ============================================
echo.

REM Node.js チェック
where npx >nul 2>nul
if %errorlevel% neq 0 (
    echo [エラー] Node.js がインストールされていません。
    echo.
    echo 先に Node.js をインストールしてください:
    echo https://nodejs.org/en/download
    echo.
    echo 「Windows Installer (.msi)」の 64-bit をダウンロードして実行してください。
    echo インストール後、このスクリプトをもう一度実行してください。
    echo.
    pause
    exit /b 1
)

echo [OK] Node.js が見つかりました
echo.

REM PowerShell で設定ファイルを更新
powershell -ExecutionPolicy Bypass -Command ^
  "$configDir = \"$env:APPDATA\Claude\";" ^
  "$configPath = \"$configDir\claude_desktop_config.json\";" ^
  "$docsPath = \"$env:USERPROFILE\Documents\";" ^
  "" ^
  "if (-not (Test-Path $configDir)) { New-Item -ItemType Directory -Path $configDir -Force | Out-Null };" ^
  "" ^
  "$config = @{};" ^
  "if (Test-Path $configPath) {" ^
  "  try { $config = Get-Content $configPath -Raw -Encoding UTF8 | ConvertFrom-Json } catch { $config = @{} }" ^
  "};" ^
  "" ^
  "if (-not $config.mcpServers) {" ^
  "  $config = [PSCustomObject]@{ mcpServers = [PSCustomObject]@{} }" ^
  "};" ^
  "" ^
  "$config.mcpServers | Add-Member -NotePropertyName 'filesystem' -NotePropertyValue ([PSCustomObject]@{" ^
  "  command = 'npx'" ^
  "  args = @('-y', '@modelcontextprotocol/server-filesystem', $docsPath)" ^
  "}) -Force;" ^
  "" ^
  "$json = $config | ConvertTo-Json -Depth 10;" ^
  "[System.IO.File]::WriteAllText($configPath, $json, [System.Text.Encoding]::UTF8);" ^
  "" ^
  "Write-Host \"[OK] 設定ファイルを更新しました: $configPath\";" ^
  "Write-Host \"[OK] アクセス許可フォルダ: $docsPath\";"

if %errorlevel% neq 0 (
    echo.
    echo [エラー] 設定ファイルの更新に失敗しました。
    echo 藤井に連絡してください。
    pause
    exit /b 1
)

echo.
echo ============================================
echo  セットアップ完了！
echo ============================================
echo.
echo Claude Desktop を再起動してください:
echo   タスクバー右下の Claude アイコンを右クリック → 「終了」 → 再度開く
echo.
echo 再起動後、Claude に「Documents フォルダの中身を見せて」と
echo 話しかけて動作確認してください。
echo.
pause
