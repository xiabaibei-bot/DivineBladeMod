#!/data/data/com.termux/files/usr/bin/bash

echo "=== 查看构建错误 ==="

# 获取最新的失败构建
RUN_ID=$(gh run list --repo=xiabaibei-bot/DivineBladeMod --status failure --limit 1 --json databaseId,number --jq '.[0].databaseId')

if [ -z "$RUN_ID" ]; then
    echo "没有找到失败的构建"
    exit 1
fi

RUN_NUM=$(gh run list --repo=xiabaibei-bot/DivineBladeMod --status failure --limit 1 --json number --jq '.[0].number')

echo "构建 #$RUN_NUM (ID: $RUN_ID)"
echo "构建页面: https://github.com/xiabaibei-bot/DivineBladeMod/actions/runs/$RUN_ID"
echo ""

# 查看关键错误
echo "=== 关键错误信息 ==="
gh run view $RUN_ID --repo=xiabaibei-bot/DivineBladeMod --log 2>&1 | \
  awk '/FAILURE:/,//' | \
  head -100

echo ""
echo "=== 如果需要查看完整日志 ==="
echo "运行: gh run view $RUN_ID --repo=xiabaibei-bot/DivineBladeMod --log | less"
