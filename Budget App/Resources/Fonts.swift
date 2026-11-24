import SwiftUI

extension Font {
    static func regular(_ size: CGFloat) -> Font { .custom("ProductSans-Regular", size: size) }
    static func bold(_ size: CGFloat) -> Font { .custom("ProductSans-Bold", size: size) }
    static func medium(_ size: CGFloat) -> Font { .custom("ProductSans-Medium", size: size) }
    static func semibold(_ size: CGFloat) -> Font { .custom("ProductSans-Medium", size: size) }
    static func light(_ size: CGFloat) -> Font { .custom("ProductSans-Light", size: size) }
    static func italic(_ size: CGFloat) -> Font { .custom("ProductSans-Italic", size: size) }
}
