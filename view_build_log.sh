#!/data/data/com.termux/files/usr/bin/bash

echo "=== 查看 GitHub Actions 构建日志 ==="

# 方法1：先尝试获取最新构建
echo "尝试获取最新构建信息..."
RUN_INFO=$(gh run list --repo=xiabaibei-bot/DivineBladeMod --limit 1 --json number,status,conclusion,databaseId,workflowName 2>/dev/null)

if [ -z "$RUN_INFO" ]; then
    echo "无法获取构建信息"
    exit 1
fi

echo "构建信息:"
echo "$RUN_INFO" | jq -r '.[] | "构建 #\(.number) - \(.workflowName) - 状态: \(.status) - 结论: \(.conclusion)"' 2>/dev/null || echo "$RUN_INFO"

# 获取构建ID
RUN_ID=$(echo "$RUN_INFO" | jq -r '.[0].databaseId' 2>/dev/null)
RUN_NUMBER=$(echo "$RUN_INFO" | jq -r '.[0].number' 2>/dev/null)

if [ -n "$RUN_ID" ]; then
    echo -e "\n查看构建 #$RUN_NUMBER 的日志 (ID: $RUN_ID)..."
    echo "=========================================="
    gh run view $RUN_ID --repo=xiabaibei-bot/DivineBladeMod --log 2>&1 | head -200
    echo "=========================================="
else
    echo "无法获取构建ID"
    gh run list --repo=xiabaibei-bot/DivineBladeMod
fi
