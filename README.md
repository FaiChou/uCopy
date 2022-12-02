# uCopy macOS App -- Yet Another Pasteboard Tool

![uCopy](https://github.com/FaiChou/uCopy/blob/main/uCopy/Assets.xcassets/AppIcon.appiconset/icon-256.png?raw=true)



-----

## TODO

- [X] 开机启动
- [x] 手动绑定快捷键
- [x] i18n
- [x] tooltip 显示更多信息
- [x] 图片/文件支持
- [x] 扩充历史粘贴板数量(二级菜单)
- [x] 自动清理超出的历史数据
- [x] 引导页
- [x] Snippet 排序功能 (由于 CoreData 没有类似 [move(fromOffsets:toOffset:)](https://developer.apple.com/documentation/Swift/MutableCollection/move(fromOffsets:toOffset:)) 接口, 需要增加一个 `order` 字段, 根据此字段和创建日期进行排序)
