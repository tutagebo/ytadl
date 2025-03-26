#!/bin/bash

set -e

REPO_URL="https://github.com/tutagebo/ytadl"
PROJECT_DIR="ytadl"

# Python3
if ! command -v python3 &> /dev/null; then
    echo "Python3 がインストールされていません。インストールします..."
    curl -O https://www.python.org/ftp/python/3.10.4/python-3.10.4-macos11.pkg
    sudo installer -pkg python-3.10.4-macos11.pkg -target /
    rm python-3.10.4-macos11.pkg
else
    echo "Python3 はすでにインストールされています。"
fi

# pip
echo "pip を最新バージョンにアップグレードします..."
python3 -m pip install --upgrade pip
if ! command -v pip3 &> /dev/null; then
    echo "pip がインストールされていません。インストールします..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
else
    echo "pip はすでにインストールされています。"
fi

# Homebrew
if ! command -v brew &> /dev/null; then
    echo "Homebrew がインストールされていません。インストールします..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ -f ~/.bash_profile ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile
        echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.bash_profile
        source ~/.bash_profile
    elif [[ -f ~/.zshrc ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
        echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
        source ~/.zshrc
    else
        echo "シェル設定ファイルが見つかりません。"
        exit 1
    fi
else
    echo "Homebrew はすでにインストールされています。"
fi

# ffmpeg
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg がインストールされていません。Homebrew を使ってインストールします..."
    brew install ffmpeg
else
    echo "ffmpeg はすでにインストールされています。"
fi

echo "GitHub からリポジトリをクローンします..."
git clone "$REPO_URL"
cd "$PROJECT_DIR"

echo "必要なパッケージ（yt-dlp, click）をインストールします..."
pip3 install -r requirements.txt

echo "コマンドラインツールをインストールします..."
pip3 install .

echo "インストールが完了しました！"
echo "コマンド `ytadl` を使って、YouTube 動画を音声としてダウンロードできます。"
echo "使い方: ytadl <URL> <保存先ディレクトリ> [--ffmpeg <FFmpegのパス>]"
