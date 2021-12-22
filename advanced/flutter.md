# Flutter

## 要求

Xcode: 12.0.1

## 开发环境搭建

1.下载稳定版flutter SDK并解压到安装目录

```bash
curl https://storage.flutter-io.cn/flutter_infra_release/releases/stable/macos/flutter_macos_2.8.1-stable.zip -O
cd /usr/local
sudo unzip ~/Downloads/flutter_macos_2.8.1-stable.zip
```

2.配置环境变量

```conf
export PATH="$PATH:/usr/local/bin/flutter/bin"
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

## [嵌入原生View-iOS](https://juejin.cn/post/6884954806692085768)