#!/data/data/com.termux/files/usr/bin/bash

cd ~/DivineBladeMod

echo "=== 项目状态检查 ==="

# 检查文件
echo "1. 检查 gradle-wrapper.jar:"
if [ -f "gradle/wrapper/gradle-wrapper.jar" ]; then
    SIZE=$(wc -c < gradle/wrapper/gradle-wrapper.jar)
    if [ $SIZE -gt 50000 ]; then
        echo "   ✅ 文件正常 ($SIZE 字节)"
    else
        echo "   ⚠️ 文件可能太小 ($SIZE 字节)"
    fi
else
    echo "   ❌ 文件不存在"
fi

# 检查 git 状态
echo -e "\n2. Git 状态:"
git status --short

# 检查提交
echo -e "\n3. 最近提交:"
git log --oneline -2

# 检查远程
echo -e "\n4. 远程仓库:"
git remote -v

echo -e "\n5. 建议操作:"
echo "   - 访问 https://github.com/xiabaibei-bot/DivineBladeMod/actions"
echo "   - 查看构建状态"
echo "   - 如果失败，点击查看错误日志"
echo "   - 如果成功，下载 JAR 文件测试"
