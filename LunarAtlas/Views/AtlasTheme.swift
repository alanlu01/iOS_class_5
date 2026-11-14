import SwiftUI
import UIKit

enum AtlasTheme {
    static let ink = Color(red: 0.052, green: 0.071, blue: 0.128)
    static let gold = Color(red: 0.98, green: 0.78, blue: 0.46)
    static let paper = adaptive(light: 0xF6F3EB, dark: 0x111727)
    static let surface = adaptive(light: 0xFFFCF5, dark: 0x1D2538)
    static let accent = adaptive(light: 0x795020, dark: 0xF9C984)
    static let rule = adaptive(light: 0xE3DBCD, dark: 0x333B4E)

    static func folio(_ text: String) -> some View {
        Text(text)
            .font(.system(.caption, design: .monospaced, weight: .semibold))
            .tracking(2.2)
            .foregroundStyle(accent)
    }

    private static func adaptive(light: UInt32, dark: UInt32) -> Color {
        Color(uiColor: UIColor { trait in
            let rgb = trait.userInterfaceStyle == .dark ? dark : light
            return UIColor(
                red: CGFloat((rgb >> 16) & 255) / 255,
                green: CGFloat((rgb >> 8) & 255) / 255,
                blue: CGFloat(rgb & 255) / 255,
                alpha: 1
            )
        })
    }
}

struct PlateImage: View {
    let plate: LunarPlate
    let height: CGFloat

    var body: some View {
        Rectangle()
            .fill(AtlasTheme.ink)
            .frame(height: height)
            .overlay {
                Image(plate.id)
                    .resizable()
                    .scaledToFill()
            }
            .clipped()
            .accessibilityHidden(true)
    }
}

struct AtlasHeading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.largeTitle, design: .serif, weight: .semibold))
            .accessibilityAddTraits(.isHeader)
    }
}

extension View {
    func atlasHeading() -> some View {
        modifier(AtlasHeading())
    }

    func atlasPage() -> some View {
        frame(maxWidth: 860)
            .padding(.horizontal, 22)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
    }
}
