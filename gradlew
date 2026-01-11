#!/usr/bin/env bash

# 检查 JAVA_HOME
if [ -n "$JAVA_HOME" ] ; then
    JAVACMD="$JAVA_HOME/bin/java"
else
    JAVACMD=java
fi

# 运行 Gradle Wrapper
exec "$JAVACMD" -jar "$(dirname "$0")/gradle/wrapper/gradle-wrapper.jar" "$@"
