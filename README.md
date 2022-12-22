# uCopy macOS App -- Yet Another Pasteboard Tool

<div align="center">

![uCopy](https://github.com/FaiChou/uCopy/blob/main/uCopy/Assets.xcassets/AppIcon.appiconset/icon-256.png?raw=true)

[![Build Status](https://app.travis-ci.com/FaiChou/uCopy.svg?branch=main)](https://app.travis-ci.com/FaiChou/uCopy)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/faichou/uCopy)](https://github.com/FaiChou/uCopy/releases)
[![GitHub](https://img.shields.io/github/license/faichou/uCopy)](https://github.com/FaiChou/uCopy/blob/main/LICENSE)

[![telegram](https://img.shields.io/badge/chat-Telegram-blueviolet?style=flat-square&logo=Telegram)](https://t.me/faichou)
[![twitter](https://img.shields.io/badge/follow-Tweet-blue?style=flat-square&logo=Twitter)](https://twitter.com/FaiChou_zh)
[![weibo](https://img.shields.io/badge/follow-Weibo-red?style=flat-square&logo=sina-weibo)](https://weibo.com/u/2949335311)

</div>

-----


## How to install

#### 1. Mac App Store

[![mac app store](https://developer.apple.com/app-store/marketing/guidelines/images/badge-download-on-the-mac-app-store.svg)](https://apps.apple.com/cn/app/ucopy/id6444760480?l=en&mt=12)


#### 2. Download from github

Github [releases](https://github.com/FaiChou/uCopy/releases) are also the same version to the Mac App Store.


## Development

#### Environment

- macOS 13 Ventura
- Xcode 14.1
- Swift 5.7.1

#### How to Run

1. Move to the project root directory
2. Open uCopy.xcodeproj
3. Run

#### Contribute

1. Fork this github project
2. Create your branch via `git checkout -b my-new-feature`
3. Commit your changes `git add . & git ci -m "some feature"`
4. Push to git `git push origin my-new-feature`
5. Create a new PR



## TODO & Features

- [X] 开机启动
- [x] 手动绑定快捷键
- [x] i18n
- [x] tooltip 显示更多信息
- [x] 图片/文件支持
- [x] 扩充历史粘贴板数量(二级菜单)
- [x] 自动清理超出的历史数据
- [x] 引导页
- [x] Snippet 排序功能 (由于 CoreData 没有类似 [move(fromOffsets:toOffset:)](https://developer.apple.com/documentation/Swift/MutableCollection/move(fromOffsets:toOffset:)) 接口, 需要增加一个 `order` 字段, 根据此字段和创建日期进行排序)

## Buy me a coffee ☕️

- [支付宝](https://github.com/FaiChou/uCopy/blob/main/oss/ali.JPG?raw=true)
- [微信](https://github.com/FaiChou/uCopy/blob/main/oss/wechat.JPG?raw=true)

## Contact Me

- [Email](mailto:faichou.zh@gmail.com)
- [Telegram](https://t.me/faichou)
- [QQ](tencent://message/?uin=95301527&Site=&Menu=yes)
