#!/data/data/com.termux/files/usr/bin/bash

echo "=== 获取 Java 编译错误 ==="

# 获取编译错误部分
gh run view 20894522891 --repo=xiabaibei-bot/DivineBladeMod --log 2>&1 | \
  awk '/:compileJava/,/BUILD FAILED/' | \
  grep -i "error\|warning\|at .*\.java" | \
  head -30

echo ""
echo "=== 或者查看所有的错误信息 ==="
gh run view 20894522891 --repo=xiabaibei-bot/DivineBladeMod --log 2>&1 | \
  grep -i "^error\|^warning" | \
  head -20
