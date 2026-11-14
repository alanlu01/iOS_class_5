# 月球觀測手冊 · Lunar Atlas

以繁體中文撰寫的 SwiftUI 電子書。手冊分為月相、月面地形與實地觀測三章，共七篇短文。

開啟 `LunarAtlas.xcodeproj`，選擇 `LunarAtlas` scheme，在 iPhone 或 iPad 模擬器執行。最低版本為 iOS／iPadOS 18，無第三方套件。專案檔已包含在 repo 中。若修改 `project.yml`，可用 `xcodegen generate` 重新產生專案檔。

## 第 88 題功能

| 作業功能 | App 中的位置 |
| --- | --- |
| 多頁面、值式導覽與標題 | 「手冊 → 章節 → 篇目」使用 `NavigationStack`、`NavigationLink(value:)` 和 `navigationDestination` 傳入章節與篇目資料 |
| iPhone 與 iPad 分頁 | `TabView` 搭配 `Tab` 和 `.sidebarAdaptable`，iPhone 顯示底部列，iPad 可從頂部列切換為側邊欄 |
| 水平翻頁 | 內文以 `.page` 顯示同章篇目，可以左右滑動，也可以用底部按鈕切換 |
| 動畫 | 封面月球緩慢縮放與漂移。閱讀頁的「觀測筆記」用彈簧動畫展開，文字以位移及淡入出現。圖鑑從點選的縮圖放大進入圖片詳情。啟用系統「減少動態效果」時停用這些動態效果 |
| 資料、表格與橫向捲動 | `Chapter`、`Entry` 和 `LunarPlate` 都遵從 `Identifiable`。手冊的直向 `List` 包含「按主題瀏覽」橫向 `ScrollView` |
| 照片牆與外部資料 | 「圖鑑」用 `LazyVGrid` 排列插畫。手冊、月相篇目和影片頁有開啟 NASA 資料的 `Link` |
| 影片 | 「影片」用 `VideoPlayer` 播放 App 內的 36.5 秒月相縮時影片，可離線觀看 |
| 系統外觀 | 支援淺色、深色與 SF Symbols。包含 App Icon、主畫面名稱及由 Info.plist 產生的 Launch Screen |

## 模擬器畫面

iPad Pro 11 吋的手冊與圖鑑。[手冊封面](docs/screenshots/ipad-cover.png) · [圖鑑](docs/screenshots/ipad-gallery.png)

## 素材

- 月球插畫和 App Icon 使用內建 ImageGen。生成指令為無字無邊框的 2×2 天文攝影風格版面，四格分別呈現近滿月、右側受光的娥眉月、側光下的月球撞擊坑和暮色山脊上的月亮。統一使用深海軍藍、銀灰與暖琥珀色。輸出裁切後存於 `LunarAtlas/Assets.xcassets`。
- 影片由 NASA Scientific Visualization Studio／Ernie Wright 製作。本專案將其 2025 年北向月相與天平動動畫加速為原速的八倍、移除音軌並重新編碼。[NASA 原始影片與說明](https://svs.gsfc.nasa.gov/5415/)
- 手冊科普參考。[NASA Moon](https://science.nasa.gov/moon/) · [NASA Moon Phases](https://science.nasa.gov/moon/moon-phases/)
- 作業題目。[第 88 題](https://medium.com/彼得潘的試煉-勇者的-100-道-swift-ios-app-謎題/88-使用-swiftui-製作電子書-app-3ae9c256c960)
