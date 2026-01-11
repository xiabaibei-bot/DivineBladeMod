#!/data/data/com.termux/files/usr/bin/bash

echo "修复 Java 环境..."

# 1. 清除错误的 JAVA_HOME
unset JAVA_HOME

# 2. 设置正确的路径
if [ -d "/data/data/com.termux/files/usr/lib/jvm/openjdk-17" ]; then
    export JAVA_HOME="/data/data/com.termux/files/usr/lib/jvm/openjdk-17"
elif [ -d "/data/data/com.termux/files/usr/lib/jvm/java-17-openjdk" ]; then
    export JAVA_HOME="/data/data/com.termux/files/usr/lib/jvm/java-17-openjdk"
else
    export JAVA_HOME="/data/data/com.termux/files/usr"
fi

export PATH="$JAVA_HOME/bin:$PATH"

echo "JAVA_HOME: $JAVA_HOME"
echo "Java版本:"
java --version

echo "尝试构建..."
cd ~/DivineBladeMod
./gradlew build
