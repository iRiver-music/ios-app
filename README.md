# iRiver iOS Music App

iRiver 是一款基於 iOS 的音樂播放與管理應用，提供用戶流暢的音樂播放體驗與豐富的音樂庫管理功能。

## 功能特色

* 🎵 **音樂播放**

  * 支援本地音樂播放與播放列表管理
  * 播放控制：播放 / 暫停 / 上一首 / 下一首
  * 循環與隨機播放模式

* 🗂 **音樂庫管理**

  * 支援歌曲新增、刪除與分類
  * 使用 Core Data 儲存播放紀錄與自訂播放列表

* 🎨 **UI 預覽與主題資源**

  * 使用 `Assets.xcassets` 管理 App 圖像與圖示資源
  * 提供簡潔、直覺的播放介面

## 專案結構

```
iRiver/
├── Assets.xcassets          # 圖像資源與 App Icon
├── Control/                 # 音樂控制器相關程式碼
├── Lib/                     # 工具函式庫與共用元件
├── Model/                   # 資料模型 (Core Data)
├── ModelView/               # MVVM 架構的 ViewModel
├── Preview Assets.xcassets   # 預覽資源
├── View/                    # UI 介面相關檔案
├── iRiver.xcdatamodeld       # Core Data 資料模型
├── Info.plist               # App 設定檔
├── Persistence.swift        # Core Data 儲存管理
├── conf.swift               # 配置與常數
└── iRiverApp.swift          # App 入口
```

## 技術棧

* **語言**：Swift
* **框架**：SwiftUI, Core Data
* **開發工具**：Xcode 15+
* **iOS 支援**：iOS 16+
