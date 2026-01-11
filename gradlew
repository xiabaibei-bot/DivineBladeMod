#!/usr/bin/env bash

# 简单的 gradlew 脚本
BASEDIR=$(dirname "$0")
JAVA_OPTS="-Xmx1024m"

# 检查 JAVA_HOME
if [ -z "$JAVA_HOME" ]; then
    JAVA_CMD=$(which java)
else
    JAVA_CMD="$JAVA_HOME/bin/java"
fi

if [ ! -x "$JAVA_CMD" ]; then
    echo "错误：找不到 Java 可执行文件"
    exit 1
fi

# 运行 Gradle Wrapper
exec "$JAVA_CMD" $JAVA_OPTS \
    -Dorg.gradle.appname="gradlew" \
    -classpath "$BASEDIR/gradle/wrapper/gradle-wrapper.jar" \
    org.gradle.wrapper.GradleWrapperMain \
    "$@"
