import SwiftUI

@main
struct LunarAtlasApp: App {
    var body: some Scene {
        WindowGroup {
            AtlasTabs()
        }
    }
}

private struct AtlasTabs: View {
    var body: some View {
        TabView {
            Tab("手冊", systemImage: "book.closed") {
                NavigationStack {
                    LibraryView()
                        .navigationDestination(for: AtlasRoute.self) { route in
                            switch route {
                            case .chapter(let chapter):
                                ChapterView(chapter: chapter)
                            case .reader(let chapter, let entry):
                                ReaderView(chapter: chapter, firstEntry: entry)
                            }
                        }
                }
            }

            Tab("圖鑑", systemImage: "square.grid.2x2") {
                NavigationStack {
                    GalleryView()
                }
            }

            Tab("影片", systemImage: "play.rectangle") {
                NavigationStack {
                    FilmView()
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .tint(AtlasTheme.accent)
    }
}
