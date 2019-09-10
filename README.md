![](/Assets/pjango.png)

<p align="center">
	<img src="https://img.shields.io/badge/Build-Passing-brightgreen.svg?style=flat">
	<img src="https://img.shields.io/badge/Swift-3.2-orange.svg?style=flat">
	<img src="https://img.shields.io/badge/Perfect-2.x-orange.svg?style=flat">
	<img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat">
	<img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat">
	<a href="https://twitter.com/zzzhyq"><img src="https://img.shields.io/badge/twitter-@zzzhyq-blue.svg?style=flat"></a>
	<a href="http://weibo.com/trmbhs"><img src="https://img.shields.io/badge/weibo-@trmbhs-red.svg?style=flat"></a>
	<img src="https://img.shields.io/badge/made%20with-%3C3-orange.svg">
</p>

一款基于 `Swift 3.x` 的服务端框架，使用 `MVC` 设计你的服务端软件。

## 更新

我正在计划结束这个项目，原因如下：

- 早起参考了一些 Django 的设计，导致无论是架构还是 API 都非常不 Swifty。
- 这个框架最早诞生于 Swift 3.x，经历了几次版本迁移，但都仅限于解决了编译问题。
- 数据库方面薄弱，写页面依然需要写 HTML，整体完成度不高。
- 早期的一些设计在今天有了更好的解决方法。

这是我第一个真正意义上的服务端项目，现如今它在线上跑了整整两年，目前依然在为我服务，但在不远的将来我会把它换下。

感谢关注。

—— 2019.07.23

新的解决方案已经开发完成，见：[https://github.com/enums/Heze](https://github.com/enums/Heze)

—— 2019.09.10

## 使用方法

- 可能需要安装 OpenSSL 1.0.2：[https://gist.github.com/mbejda/a1dabc45b32aaf8b25ae5e8d05923518](https://gist.github.com/mbejda/a1dabc45b32aaf8b25ae5e8d05923518)

- 克隆此仓库
- macOS：使用下面的命令生成 Xcode 工程进行编译：

```bash
$ swift package generate-xcodeproj
```

- Linux：使用`Swift Package Manager`编译：

```bash
$ swift build
```

## 范例

- [基础模板](https://github.com/enums/pjango-template)：最基础的例子。
- [Calatrava](https://github.com/enums/calatrava)：我的开源博客，Pjango 的深度使用。
- [Postman](https://github.com/enums/postman)：HTTP 转发服务器，Calatrava 中的 Instagram 模块依赖在远程服务器部署的 Postman。

## 组件

### 模型组件

- Pjango-Core-Model：内置的模型核心驱动。

### 视图组件

- Pjango-Core-View：内置的视图核心驱动。
- Pjango-Core-ListView：内置的列表类视图。
- Pjango-Core-DetailView：内置的展示类视图。

### 数据库组件

- Pjango-Core-DataBase：内置的数据库核心驱动。
- Pjango-Core-FileDB：内置的文件驱动组件。
- [Pjango-MySQL](https://github.com/enums/pjango-mysql)：MySQL 数据库支持组件。

### 插件式组件

- Pjango-Core-Plugin：内置的插件核心驱动。
- Pjango-Core-TaskPlugin：内置的一次性任务组件。
- Pjango-Core-TimerPlugin：内置的延时、定时、重复定时任务组件。
- Pjango-Core-HTTPFilterPlugin：内置的 HTTP 服务过滤器组件。
- Pjango-Core-LogFilterPlugin：内置的 HTTP 过滤器日志组件。

### 其他功能组件

- [Pjango-JianshuPlugin](https://github.com/enums/Pjango-JianshuPlugin)：简书的定时爬虫组件。
- [Pjango-SteamPlugin](https://github.com/enums/Pjango-SteamPlugin)：Steam 主页背景图和头像的抓取以及适用于 Calatrava 的背景和头像的替换。
- [Pjango-Postman](https://github.com/enums/Pjango-Postman)：向 Postman 代理发出请求的组件。


## 联系我

发邮件给我：[enum@enumsblog.com](mailto:enum@enumsblog.com)

## 协议

<img alt="Apache-2.0 license" src="https://lucene.apache.org/images/mantle-power.png" width="128">

Pjango 基于 Apache-2.0 协议进行分发和使用，更多信息参见协议文件。
