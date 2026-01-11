#!/data/data/com.termux/files/usr/bin/bash

echo "获取构建错误的前100行..."

# 获取最新构建ID
RUN_ID=$(gh run list --repo=xiabaibei-bot/DivineBladeMod --status failure --limit 1 --json databaseId --jq '.[0].databaseId')

if [ -n "$RUN_ID" ]; then
    echo "构建ID: $RUN_ID"
    echo "=== 错误开头 ==="
    gh run view $RUN_ID --repo=xiabaibei-bot/DivineBladeMod --log 2>&1 | head -100
    echo "=== 错误结尾 ==="
    gh run view $RUN_ID --repo=xiabaibei-bot/DivineBladeMod --log 2>&1 | tail -50
else
    echo "没有找到失败的构建"
fi
