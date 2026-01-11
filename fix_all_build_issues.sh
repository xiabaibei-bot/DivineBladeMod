#!/data/data/com.termux/files/usr/bin/bash

cd ~/DivineBladeMod

echo "=== 修复所有构建问题 ==="

# 1. 更新 GitHub Actions 配置
mkdir -p .github/workflows
cat > .github/workflows/build.yml << 'ACTIONEOF'
name: Build DivineBlade Mod

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Set up JDK 17
      uses: actions/setup-java@v4
      with:
        java-version: '17'
        distribution: 'temurin'
        cache: 'gradle'
    
    - name: Cache Gradle dependencies
      uses: actions/cache@v4
      with:
        path: |
          ~/.gradle/caches
          ~/.gradle/wrapper
        key: \${{ runner.os }}-gradle-\${{ hashFiles('**/*.gradle*', '**/gradle-wrapper.properties') }}
        restore-keys: |
          \${{ runner.os }}-gradle-
    
    - name: Make gradlew executable
      run: chmod +x gradlew
      
    - name: Build with Gradle
      run: ./gradlew build --no-daemon --stacktrace
      
    - name: Upload JAR as artifact
      if: success()
      uses: actions/upload-artifact@v4
      with:
        name: DivineBlade-Mod
        path: build/libs/*.jar
        retention-days: 7
ACTIONEOF

# 2. 确保有必要的目录结构
mkdir -p src/main/resources/META-INF

# 3. 提交并推送
git add .
git commit -m "Fix build configuration: update GitHub Actions and build.gradle"
git push

echo "修复已提交！"
echo "查看构建状态: https://github.com/xiabaibei-bot/DivineBladeMod/actions"
echo ""
echo "预计构建时间: 5-10分钟"
echo "如果构建失败，请将错误信息发给我"
