import SwiftUI

struct GalleryView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Namespace private var plates

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("月面與夜空")
                    .atlasHeading()
                Text("點開插畫，查看對應的觀測說明。")
                    .foregroundStyle(.secondary)

                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: sizeClass == .regular ? 225 : 142), spacing: 14)],
                    spacing: 14
                ) {
                    ForEach(LunarPlate.all) { plate in
                        NavigationLink(value: plate) {
                            VStack(alignment: .leading, spacing: 0) {
                                PlateImage(plate: plate, height: sizeClass == .regular ? 200 : 132)
                                Text(plate.title)
                                    .font(.headline)
                                    .padding(12)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .background(AtlasTheme.surface)
                            .clipShape(.rect(cornerRadius: 14))
                            .overlay { RoundedRectangle(cornerRadius: 14).strokeBorder(AtlasTheme.rule) }
                        }
                        .buttonStyle(.plain)
                        .matchedTransitionSource(id: plate.id, in: plates)
                        .accessibilityIdentifier("plate-\(plate.id)")
                    }
                }

                Text("圖鑑為 AI 生成的示意插畫。")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .atlasPage()
        }
        .background(AtlasTheme.paper.ignoresSafeArea())
        .navigationTitle("圖鑑")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: LunarPlate.self) { plate in
            if reduceMotion {
                PlateView(plate: plate)
            } else {
                PlateView(plate: plate)
                    .navigationTransition(.zoom(sourceID: plate.id, in: plates))
            }
        }
    }
}

struct PlateView: View {
    let plate: LunarPlate

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(plate.id)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 580)
                    .clipShape(.rect(cornerRadius: 18))
                    .accessibilityLabel(plate.title)

                Text(plate.title)
                    .atlasHeading()
                Text(plate.caption)
                    .font(.body)
                    .lineSpacing(6)
            }
            .frame(maxWidth: 580, alignment: .leading)
            .atlasPage()
        }
        .background(AtlasTheme.paper.ignoresSafeArea())
        .navigationTitle(plate.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
