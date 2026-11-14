import SwiftUI

struct LibraryView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var illuminated = false

    var body: some View {
        List {
            cover
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)

            Section {
                ForEach(Chapter.all) { chapter in
                    NavigationLink(value: AtlasRoute.chapter(chapter)) {
                        chapterRow(chapter)
                    }
                    .accessibilityIdentifier("chapter-\(chapter.id)")
                    .listRowBackground(AtlasTheme.surface)
                }
            } header: {
                AtlasTheme.folio("目錄")
                    .padding(.top, 5)
            }

            Section {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(Chapter.all) { chapter in
                            NavigationLink(value: AtlasRoute.chapter(chapter)) {
                                chapterCard(chapter)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            } header: {
                AtlasTheme.folio("按主題瀏覽")
            }

            Section {
                Link(destination: AtlasSources.moon) {
                    Label("NASA 月球資料", systemImage: "arrow.up.right.square")
                }
                .listRowBackground(AtlasTheme.surface)
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(AtlasTheme.paper.ignoresSafeArea())
        .navigationTitle("手冊")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                illuminated = true
            }
        }
    }

    private var cover: some View {
        VStack(spacing: 0) {
            Image("FullMoon")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 290)
                .mask {
                    RadialGradient(
                        stops: [.init(color: .black, location: 0.81), .init(color: .clear, location: 1)],
                        center: .center,
                        startRadius: 0,
                        endRadius: 150
                    )
                }
                .scaleEffect(illuminated ? 1.045 : 0.98)
                .offset(y: illuminated ? -3 : 3)
                .accessibilityHidden(true)

            VStack(spacing: 9) {
                Text("L U N A R   A T L A S")
                    .font(.system(.caption, design: .monospaced, weight: .medium))
                    .foregroundStyle(AtlasTheme.gold)

                Text("月球觀測手冊")
                    .atlasHeading()
                    .foregroundStyle(.white)

                Text("從月相、月海到你的第一晚觀測。")
                    .font(.subheadline)
                    .foregroundStyle(Color.white.opacity(0.78))
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
            .padding(.bottom, 25)
            .frame(maxWidth: .infinity)
        }
        .background {
            RadialGradient(
                colors: [Color(red: 0.12, green: 0.16, blue: 0.25), AtlasTheme.ink],
                center: .top,
                startRadius: 10,
                endRadius: 440
            )
        }
        .clipShape(.rect(cornerRadius: 24))
    }

    private func chapterRow(_ chapter: Chapter) -> some View {
        HStack(spacing: 15) {
            AtlasTheme.folio(chapter.id)
                .padding(10)
                .background(AtlasTheme.paper, in: .rect(cornerRadius: 9))

            VStack(alignment: .leading, spacing: 4) {
                Text(chapter.title)
                    .font(.headline)
                Text(chapter.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
    }

    private func chapterCard(_ chapter: Chapter) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            PlateImage(plate: chapter.plate, height: 112)
            Text(chapter.title)
                .font(.subheadline.weight(.semibold))
                .padding(11)
        }
        .frame(width: 155)
        .background(AtlasTheme.surface)
        .clipShape(.rect(cornerRadius: 14))
        .overlay { RoundedRectangle(cornerRadius: 14).strokeBorder(AtlasTheme.rule) }
    }
}
