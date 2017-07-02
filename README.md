# Pjango


<p align="center">
	<img src="https://img.shields.io/badge/Build-Passing-brightgreen.svg?style=flat">
	<img src="https://img.shields.io/badge/Swift-3.2-orange.svg?style=flat">
	<img src="https://img.shields.io/badge/Perfect-2.x-orange.svg?style=flat">
   <img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat">
   <img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat">
</p>

一款基于`Swift 3.x`的服务端框架，使用`MVC`设计你的服务端软件。


## 使用方法

- 可能需要安装 OpenSSL 1.0.2: [https://gist.github.com/mbejda/a1dabc45b32aaf8b25ae5e8d05923518](https://gist.github.com/mbejda/a1dabc45b32aaf8b25ae5e8d05923518)

- 克隆此仓库
- macOS: 使用下面的命令生成 Xcode 工程进行编译:

```bash
$ swift package generate-xcodeproj
```

- Linux: 使用`Swift Package Manager`编译:

```bash
$ swift build
```

## 范例

- [基础模板](https://github.com/enums/pjango-template): 最基础的例子。

## 组件

### 模型组件

- Pjango-Core-Model: 内置的模型核心驱动。

### 视图组件

- Pjango-Core-View: 内置的视图核心驱动。
- Pjango-Core-ListView: 内置的列表类视图。
- Pjango-Core-DetailView: 内置的展示类视图。

### 数据库组件

- Pjango-Core-DataBase: 内置的数据库核心驱动。
- Pjango-Core-FileDB: 内置的文件驱动组件。
- [Pjango-MySQL](https://github.com/enums/pjango-mysql): MySQL 数据库支持组件。


### 插件式组件

- Pjango-Core-Plugin: 内置的插件核心驱动。
- Pjango-Core-TaskPlugin: 内置的一次性任务组件。
- Pjango-Core-TimerPlugin: 内置的延时、定时、重复定时任务组件。
- Pjango-Core-HTTPFilterPlugin: 内置的 HTTP 服务过滤器组件。
- Pjango-Core-LogFilterPlugin: 内置的 HTTP 过滤器日志组件。

### 其他功能组件

- [Pjango-JianshuPlugin](https://github.com/enums/Pjango-JianshuPlugin): 简书的定时爬虫组件。

## 联系我

发邮件给我: [enum@enumsblog.com](mailto:enum@enumsblog.com)

