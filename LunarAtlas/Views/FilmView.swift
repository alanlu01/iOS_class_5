import AVKit
import SwiftUI

struct FilmView: View {
    @State private var player: AVPlayer?
    @State private var isPlaying = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                AtlasTheme.folio("NASA SCIENTIFIC VISUALIZATION STUDIO")
                Text("一年份的月相")
                    .atlasHeading()
                Text("用縮時影像看月相盈虧，以及月面在視野中的輕微擺動。")
                    .foregroundStyle(.secondary)

                Group {
                    if let player {
                        VideoPlayer(player: player)
                            .accessibilityIdentifier("moon-video")
                    } else {
                        ContentUnavailableView("找不到影片", systemImage: "film.slash")
                    }
                }
                .aspectRatio(16.0 / 9.0, contentMode: .fit)
                .background(.black)
                .clipShape(.rect(cornerRadius: 17))

                if let player {
                    Button {
                        if isPlaying {
                            player.pause()
                        } else {
                            let duration = player.currentItem?.duration.seconds ?? .nan
                            if duration.isFinite && player.currentTime().seconds >= duration - 0.1 {
                                player.seek(to: .zero)
                            }
                            player.play()
                        }
                    } label: {
                        Label(isPlaying ? "暫停影片" : "播放影片", systemImage: isPlaying ? "pause.fill" : "play.fill")
                            .frame(minHeight: 36)
                    }
                    .buttonStyle(.bordered)
                    .accessibilityIdentifier("film-playback")
                    .onReceive(player.publisher(for: \.timeControlStatus)) { status in
                        isPlaying = status != .paused
                    }
                }

                Text("影像製作：NASA SVS／Ernie Wright。App 內為 2025 年動畫的無聲加速版。")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Link(destination: AtlasSources.film) {
                    Label("查看 NASA 原始影片與說明", systemImage: "arrow.up.right.square")
                }
                .font(.subheadline.weight(.semibold))
            }
            .atlasPage()
        }
        .background(AtlasTheme.paper.ignoresSafeArea())
        .navigationTitle("影片")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if player == nil, let url = Bundle.main.url(forResource: "moon-phases", withExtension: "mp4") {
                player = AVPlayer(url: url)
            }
        }
        .onDisappear { player?.pause() }
    }
}
