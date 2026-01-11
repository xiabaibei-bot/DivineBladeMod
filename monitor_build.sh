#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 开始监控 GitHub Actions 构建状态..."
echo "仓库: xiabaibei-bot/DivineBladeMod"
echo "按 Ctrl+C 停止监控"
echo ""

# 获取最新构建的ID
get_latest_run_id() {
    gh run list --repo=xiabaibei-bot/DivineBladeMod --limit 1 --json databaseId --jq '.[0].databaseId' 2>/dev/null
}

# 获取构建状态
get_run_status() {
    local run_id=$1
    gh run view $run_id --repo=xiabaibei-bot/DivineBladeMod --json status,conclusion,workflowName,event,headBranch,displayTitle --jq '
        "构建状态: " + .status + 
        "\n构建结果: " + (.conclusion // "运行中") + 
        "\n工作流: " + .workflowName + 
        "\n分支: " + .headBranch + 
        "\n事件: " + .event + 
        "\n标题: " + .displayTitle
    ' 2>/dev/null
}

# 监控函数
monitor() {
    echo "🔍 查找最新构建..."
    RUN_ID=$(get_latest_run_id)
    
    if [ -z "$RUN_ID" ]; then
        echo "❌ 没有找到构建记录"
        return 1
    fi
    
    echo "📋 构建 ID: $RUN_ID"
    echo "🔗 构建页面: https://github.com/xiabaibei-bot/DivineBladeMod/actions/runs/$RUN_ID"
    echo ""
    
    PREV_STATUS=""
    while true; do
        STATUS_INFO=$(get_run_status $RUN_ID)
        
        if [ "$STATUS_INFO" != "$PREV_STATUS" ]; then
            clear
            echo "=== GitHub Actions 实时监控 ==="
            echo "$STATUS_INFO"
            echo ""
            echo "📅 更新时间: $(date '+%Y-%m-%d %H:%M:%S')"
            echo "🔄 每10秒刷新一次..."
            echo ""
            
            # 检查构建是否完成
            if echo "$STATUS_INFO" | grep -q "构建结果: completed"; then
                CONCLUSION=$(echo "$STATUS_INFO" | grep "构建结果:" | cut -d: -f2 | xargs)
                if [ "$CONCLUSION" = "success" ]; then
                    echo "🎉 构建成功！"
                    echo "✅ 可以下载 JAR 文件了"
                    break
                elif [ "$CONCLUSION" = "failure" ]; then
                    echo "❌ 构建失败！"
                    echo "📋 查看错误日志:"
                    gh run view $RUN_ID --repo=xiabaibei-bot/DivineBladeMod --log 2>&1 | tail -20
                    break
                fi
            fi
            PREV_STATUS="$STATUS_INFO"
        fi
        
        sleep 10
    done
}

# 运行监控
monitor
