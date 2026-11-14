import SwiftUI

struct ReaderView: View {
    let chapter: Chapter
    @State private var selectedID: Entry.ID

    init(chapter: Chapter, firstEntry: Entry) {
        self.chapter = chapter
        _selectedID = State(initialValue: firstEntry.id)
    }

    private var pageIndex: Int {
        chapter.entries.firstIndex { $0.id == selectedID } ?? 0
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedID) {
                ForEach(chapter.entries) { entry in
                    ReadingPage(chapter: chapter, entry: entry)
                        .tag(entry.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .accessibilityIdentifier("reader-pager")

            HStack {
                pageButton("上一頁", icon: "chevron.left", offset: -1)
                Spacer()
                Text("\(pageIndex + 1) / \(chapter.entries.count)")
                    .font(.system(.subheadline, design: .monospaced))
                    .foregroundStyle(.secondary)
                    .accessibilityLabel("第 \(pageIndex + 1) 頁，共 \(chapter.entries.count) 頁")
                    .accessibilityIdentifier("page-number")
                Spacer()
                pageButton("下一頁", icon: "chevron.right", offset: 1)
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 6)
            .background(AtlasTheme.surface)
            .overlay(alignment: .top) { Divider() }
        }
        .background(AtlasTheme.paper.ignoresSafeArea())
        .navigationTitle(chapter.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func pageButton(_ title: String, icon: String, offset: Int) -> some View {
        let index = pageIndex + offset
        return Button {
            guard chapter.entries.indices.contains(index) else { return }
            selectedID = chapter.entries[index].id
        } label: {
            Image(systemName: icon)
                .font(.headline)
                .frame(width: 46, height: 44)
        }
        .disabled(!chapter.entries.indices.contains(index))
        .accessibilityLabel(title)
    }
}

private struct ReadingPage: View {
    let chapter: Chapter
    let entry: Entry
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var showsNote = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                PlateImage(plate: illustration, height: 204)
                    .clipShape(.rect(cornerRadius: 17))

                AtlasTheme.folio(chapter.title)
                Text(entry.title)
                    .atlasHeading()
                    .accessibilityIdentifier("reader-title-\(entry.id)")

                Text(entry.text)
                    .font(.body)
                    .lineSpacing(8)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(alignment: .leading, spacing: 12) {
                    Button {
                        withAnimation(reduceMotion ? nil : .spring(duration: 0.42, bounce: 0.16)) {
                            showsNote.toggle()
                        }
                    } label: {
                        HStack {
                            Label("觀測筆記", systemImage: "note.text")
                            Spacer()
                            Image(systemName: "chevron.down")
                                .rotationEffect(.degrees(showsNote ? 180 : 0))
                                .accessibilityHidden(true)
                        }
                        .font(.headline)
                        .frame(minHeight: 44)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(AtlasTheme.accent)
                    .accessibilityValue(showsNote ? "已展開" : "已收合")
                    .accessibilityIdentifier("field-note-toggle")

                    if showsNote {
                        Text(entry.fieldNote)
                            .font(.subheadline)
                            .lineSpacing(5)
                            .fixedSize(horizontal: false, vertical: true)
                            .transition(reduceMotion ? .identity : .move(edge: .top).combined(with: .opacity))
                            .accessibilityIdentifier("field-note-text")
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(AtlasTheme.surface)
                .clipShape(.rect(cornerRadius: 13))
                .overlay { RoundedRectangle(cornerRadius: 13).strokeBorder(AtlasTheme.rule) }

                if chapter.id == "01" {
                    Link(destination: AtlasSources.phases) {
                        Label("NASA 月相解說", systemImage: "arrow.up.right.square")
                    }
                }
            }
            .atlasPage()
        }
        .accessibilityIdentifier("reader-page-\(entry.id)")
    }

    private var illustration: LunarPlate {
        entry.id == "full" ? .full : chapter.plate
    }
}
