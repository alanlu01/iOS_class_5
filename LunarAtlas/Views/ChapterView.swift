import SwiftUI

struct ChapterView: View {
    let chapter: Chapter

    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 12) {
                PlateImage(plate: chapter.plate, height: 220)
                    .clipShape(.rect(cornerRadius: 16))

                AtlasTheme.folio("第 \(chapter.id) 章")
                Text(chapter.title)
                    .atlasHeading()
                Text(chapter.subtitle)
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom, 10)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)

            Section {
                ForEach(chapter.entries) { entry in
                    NavigationLink(value: AtlasRoute.reader(chapter, entry)) {
                        Label(entry.title, systemImage: entry.symbol)
                            .padding(.vertical, 9)
                    }
                    .accessibilityIdentifier("entry-\(entry.id)")
                    .listRowBackground(AtlasTheme.surface)
                }
            } header: {
                AtlasTheme.folio("篇目")
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(AtlasTheme.paper.ignoresSafeArea())
        .navigationTitle(chapter.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
