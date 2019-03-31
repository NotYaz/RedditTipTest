// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
  internal typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  internal typealias Font = UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum IBMPlexSans {
    internal static let regular = FontConvertible(name: "IBMPlexSans", family: "IBM Plex Sans", path: "IBMPlexSans-Regular.ttf")
    internal static let bold = FontConvertible(name: "IBMPlexSans-Bold", family: "IBM Plex Sans", path: "IBMPlexSans-Bold.ttf")
    internal static let boldItalic = FontConvertible(name: "IBMPlexSans-BoldItalic", family: "IBM Plex Sans", path: "IBMPlexSans-BoldItalic.ttf")
    internal static let extraLight = FontConvertible(name: "IBMPlexSans-ExtraLight", family: "IBM Plex Sans", path: "IBMPlexSans-ExtraLight.ttf")
    internal static let extraLightItalic = FontConvertible(name: "IBMPlexSans-ExtraLightItalic", family: "IBM Plex Sans", path: "IBMPlexSans-ExtraLightItalic.ttf")
    internal static let italic = FontConvertible(name: "IBMPlexSans-Italic", family: "IBM Plex Sans", path: "IBMPlexSans-Italic.ttf")
    internal static let light = FontConvertible(name: "IBMPlexSans-Light", family: "IBM Plex Sans", path: "IBMPlexSans-Light.ttf")
    internal static let lightItalic = FontConvertible(name: "IBMPlexSans-LightItalic", family: "IBM Plex Sans", path: "IBMPlexSans-LightItalic.ttf")
    internal static let medium = FontConvertible(name: "IBMPlexSans-Medium", family: "IBM Plex Sans", path: "IBMPlexSans-Medium.ttf")
    internal static let mediumItalic = FontConvertible(name: "IBMPlexSans-MediumItalic", family: "IBM Plex Sans", path: "IBMPlexSans-MediumItalic.ttf")
    internal static let semiBold = FontConvertible(name: "IBMPlexSans-SemiBold", family: "IBM Plex Sans", path: "IBMPlexSans-SemiBold.ttf")
    internal static let semiBoldItalic = FontConvertible(name: "IBMPlexSans-SemiBoldItalic", family: "IBM Plex Sans", path: "IBMPlexSans-SemiBoldItalic.ttf")
    internal static let text = FontConvertible(name: "IBMPlexSans-Text", family: "IBM Plex Sans", path: "IBMPlexSans-Text.ttf")
    internal static let textItalic = FontConvertible(name: "IBMPlexSans-TextItalic", family: "IBM Plex Sans", path: "IBMPlexSans-TextItalic.ttf")
    internal static let thin = FontConvertible(name: "IBMPlexSans-Thin", family: "IBM Plex Sans", path: "IBMPlexSans-Thin.ttf")
    internal static let thinItalic = FontConvertible(name: "IBMPlexSans-ThinItalic", family: "IBM Plex Sans", path: "IBMPlexSans-ThinItalic.ttf")
    internal static let all: [FontConvertible] = [regular, bold, boldItalic, extraLight, extraLightItalic, italic, light, lightItalic, medium, mediumItalic, semiBold, semiBoldItalic, text, textItalic, thin, thinItalic]
  }
  internal static let allCustomFonts: [FontConvertible] = [IBMPlexSans.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  internal func font(size: CGFloat) -> Font! {
    return Font(font: self, size: size)
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    let bundle = Bundle(for: BundleToken.self)
    return bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension Font {
  convenience init!(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

private final class BundleToken {}
