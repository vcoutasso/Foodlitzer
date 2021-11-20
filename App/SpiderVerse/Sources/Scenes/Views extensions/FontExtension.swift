import SwiftUI

extension Font {
    // MARK: - Fonts Style

    enum Compact {
        case regular
        case italic
        case ultraLight
        case light
        case lightItalic
        case medium
        case mediumItalic
        case semiBold
        case semiBoldItalic
        case Bold
        case BoldItalic

        var value: String {
            switch self {
            case .regular:
                return Strings.Font.compactRegular
            case .italic:
                return Strings.Font.compactItalic
            case .ultraLight:
                return Strings.Font.compactUltralight
            case .light:
                return Strings.Font.compactLight
            case .lightItalic:
                return Strings.Font.compactLightItalic
            case .medium:
                return Strings.Font.compactMedium
            case .mediumItalic:
                return Strings.Font.compactMediumItalic
            case .semiBold:
                return Strings.Font.compactSemibold
            case .semiBoldItalic:
                return Strings.Font.compactSemiboldItalic
            case .Bold:
                return Strings.Font.compactBold
            case .BoldItalic:
                return Strings.Font.compactBoldItalic
            }
        }
    }

    enum Lora {
        case regular
        case italic
        case medium
        case mediumItalic
        case semiBold
        case semiBoldItalic
        case bold
        case boldItalic

        var value: String {
            switch self {
            case .regular:
                return Strings.Font.loraRegular
            case .italic:
                return Strings.Font.loraItalic
            case .medium:
                return Strings.Font.loraMedium
            case .mediumItalic:
                return Strings.Font.loraMediumItalic
            case .semiBold:
                return Strings.Font.loraSemiBold
            case .semiBoldItalic:
                return Strings.Font.loraBoldItalic
            case .bold:
                return Strings.Font.loraBold
            case .boldItalic:
                return Strings.Font.loraItalic
            }
        }
    }

    // MARK: - Implementation Methods

    static func compact(_ type: Compact, size: CGFloat = 12) -> Font {
        .custom(type.value, size: size)
    }

    static func lora(_ type: Lora, size: CGFloat = 12) -> Font {
        .custom(type.value, size: size)
    }
}
