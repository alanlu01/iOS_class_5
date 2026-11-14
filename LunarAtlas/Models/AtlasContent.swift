import Foundation

enum AtlasRoute: Hashable {
    case chapter(Chapter)
    case reader(Chapter, Entry)
}

struct Entry: Identifiable, Hashable {
    let id: String
    let title: String
    let symbol: String
    let text: String
    let fieldNote: String
}

struct Chapter: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let plate: LunarPlate
    let entries: [Entry]

    static let all: [Chapter] = [
        Chapter(
            id: "01",
            title: "認識月相",
            subtitle: "從新月到滿月，讀懂每晚的變化。",
            plate: .crescent,
            entries: [
                Entry(
                    id: "new",
                    title: "新月與眉月",
                    symbol: "moon",
                    text: "月球繞行地球時，太陽一直照亮它的一半。我們從地球看到的受光比例隨位置改變，於是形成月相。新月時，月球位於天空中接近太陽的方向，朝向地球的一面幾乎全暗。幾天後，日落西方出現一彎細月，就是逐漸增亮的娥眉月。",
                    fieldNote: "等太陽完全落下再用雙筒望遠鏡搜尋低空眉月。可先用肉眼確定方向，切勿拿望遠鏡掃視太陽附近。"
                ),
                Entry(
                    id: "quarter",
                    title: "上弦月",
                    symbol: "moonphase.first.quarter",
                    text: "約在新月一週後，月球完成約四分之一的月相週期。我們看到的月面有一半明亮。上弦月從下午到午夜前後都可能可見，傍晚是方便從城市觀察的時段。",
                    fieldNote: "沿著明暗交界線移動視線。斜射的陽光把環形山的陰影拉長，低倍率就能看見地形高低。"
                ),
                Entry(
                    id: "full",
                    title: "滿月",
                    symbol: "moonphase.full.moon",
                    text: "滿月時，從地球看去，月球大致位於太陽的反方向。它在日落前後升起，日出前後落下。光線接近從觀測者背後照去，月面陰影短，但暗色月海和明亮的撞擊輻射紋容易辨識。",
                    fieldNote: "試著用肉眼描出暗色月海的輪廓，再用低倍率觀察明亮的第谷環形山輻射紋。"
                )
            ]
        ),
        Chapter(
            id: "02",
            title: "辨識月面",
            subtitle: "在明暗交界處，找到環形山和月海。",
            plate: .craters,
            entries: [
                Entry(
                    id: "maria",
                    title: "月海",
                    symbol: "circle.lefthalf.filled",
                    text: "月海是月面上的暗色平原。古代觀測者以為這些區域是海洋，於是留下了名稱。許多月海來自覆蓋大型撞擊盆地的玄武岩熔岩，冷卻後形成大片平坦地形。",
                    fieldNote: "靜海在月球近側。先以月面上較明顯的暗區比對月圖，再沿邊緣辨識相鄰地形。"
                ),
                Entry(
                    id: "craters",
                    title: "環形山",
                    symbol: "circle.circle",
                    text: "小天體撞擊月面時會挖出坑洞，並把碎屑拋到外圍。較大的撞擊坑可能有中央山峰與階梯狀坑壁。月球缺少能迅速抹平這些地形的風雨，因此保留了大量古老的撞擊記錄。",
                    fieldNote: "在上弦月前後找明暗交界附近的坑緣。過幾天重看同一區，照明角度一變，陰影形狀也會變。"
                )
            ]
        ),
        Chapter(
            id: "03",
            title: "出門觀測",
            subtitle: "用肉眼或雙筒望遠鏡，開始第一晚的紀錄。",
            plate: .horizon,
            entries: [
                Entry(
                    id: "plan",
                    title: "規劃一晚",
                    symbol: "binoculars",
                    text: "先確認雲量和當地的月出、月落時間，再挑一處視線開闊且能安全停留的地方。月球夠亮，在城市裡也能觀察。月球升得較高時，穿過的大氣較少，影像通常更穩定。",
                    fieldNote: "用肉眼找到月球，再舉起雙筒望遠鏡。坐下來把手肘靠穩，比一開始追求高倍率更容易看清楚。"
                ),
                Entry(
                    id: "journal",
                    title: "寫觀測日誌",
                    symbol: "pencil.and.list.clipboard",
                    text: "記下日期、時間、地點和月亮所在方向。畫出光照邊界以及兩三處辨識出來的地形。連續幾晚用相同方式記錄，便能比較月相、月升時間和地形陰影的變化。",
                    fieldNote: "標註天氣、倍率和影像方向。有些望遠鏡的視野會旋轉或鏡像反轉，對照月圖前先確認方向。"
                )
            ]
        )
    ]
}

struct LunarPlate: Identifiable, Hashable {
    let id: String
    let title: String
    let caption: String

    static let full = Self(id: "FullMoon", title: "近望之月", caption: "接近滿月時，大面積的暗色月海相當醒目。")
    static let crescent = Self(id: "Crescent", title: "娥眉月", caption: "新月後不久，月球受光的一側在傍晚西方露出細弧。")
    static let craters = Self(id: "Craters", title: "撞擊地形", caption: "光線以低角度掠過月面時，坑緣和陰影會凸顯地形的起伏。")
    static let horizon = Self(id: "Horizon", title: "暮色月升", caption: "低空的月球容易與山稜一起入鏡。要看細節，可以等月亮升高。")

    static let all: [Self] = [.full, .crescent, .craters, .horizon]
}

enum AtlasSources {
    static let moon = URL(string: "https://science.nasa.gov/moon/")!
    static let phases = URL(string: "https://science.nasa.gov/moon/moon-phases/")!
    static let film = URL(string: "https://svs.gsfc.nasa.gov/5415/")!
}
