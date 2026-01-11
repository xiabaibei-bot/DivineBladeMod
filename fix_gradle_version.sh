#!/data/data/com.termux/files/usr/bin/bash

echo "=== 修复 Gradle 版本兼容性问题 ==="

# 1. 升级到 Gradle 8.7
echo "升级 Gradle 到 8.7..."
cat > gradle/wrapper/gradle-wrapper.properties << 'PROPEOF'
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.7-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
PROPEOF

# 2. 确保 build.gradle 使用正确的插件
echo "更新 build.gradle..."
cat > build.gradle << 'GRADLEEOF'
plugins {
    id 'net.neoforged.gradle.userdev' version '7.0.142'
}

apply plugin: 'java'

java.toolchain.languageVersion = JavaLanguageVersion.of(17)

repositories {
    maven {
        name = 'NeoForged'
        url = 'https://maven.neoforged.net/releases'
    }
    mavenCentral()
}

dependencies {
    implementation "net.neoforged:neoforge:20.4.205"
}

tasks.withType(JavaCompile).configureEach {
    options.encoding = 'UTF-8'
}
GRADLEEOF

# 3. 提交
echo "提交修复..."
git add gradle/wrapper/gradle-wrapper.properties build.gradle
git commit -m "Fix: Upgrade to Gradle 8.7 for NeoForge plugin compatibility"
git push

echo "✅ 修复已提交！"
echo "GitHub Actions 将使用 Gradle 8.7 重新构建。"
