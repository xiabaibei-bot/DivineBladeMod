#!/data/data/com.termux/files/usr/bin/bash

TOKEN="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"
REPO="xiabaibei-bot/DivineBladeMod"

echo "获取最新构建状态..."

# 获取最新构建的ID
BUILD_INFO=$(curl -s -H "Authorization: token $TOKEN" \
  "https://api.github.com/repos/$REPO/actions/runs?per_page=1")

echo "构建信息:"
echo "$BUILD_INFO" | grep -o '"run_number":[0-9]*\|"status":"[^"]*"\|"conclusion":"[^"]*"\|"html_url":"[^"]*"' | head -10

# 提取构建ID
BUILD_ID=$(echo "$BUILD_INFO" | grep -o '"id":[0-9]*' | head -1 | cut -d: -f2)

if [ -n "$BUILD_ID" ]; then
    echo -e "\n构建 ID: $BUILD_ID"
    echo "构建页面: https://github.com/$REPO/actions/runs/$BUILD_ID"
    
    # 尝试获取作业日志
    echo -e "\n正在获取作业列表..."
    JOBS=$(curl -s -H "Authorization: token $TOKEN" \
      "https://api.github.com/repos/$REPO/actions/runs/$BUILD_ID/jobs")
    
    JOB_ID=$(echo "$JOBS" | grep -o '"id":[0-9]*' | head -1 | cut -d: -f2)
    
    if [ -n "$JOB_ID" ]; then
        echo "作业 ID: $JOB_ID"
        echo -e "\n获取日志（最后50行）..."
        curl -s -H "Authorization: token $TOKEN" \
          "https://api.github.com/repos/$REPO/actions/jobs/$JOB_ID/logs" 2>/dev/null | tail -50
    fi
fi
