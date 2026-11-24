//
//  Fonts.swift
//  Budget App
//
//  Created by Sonnie on 24/11/2026.
//

import Foundation
import SwiftUI

extension Font {
    static func regular(_ size: CGFloat)-> Font {
        return Font.custom("ProductSans-Regular", size: size)
    }
    
    static func bold(_ size: CGFloat)-> Font {
        return Font.custom("ProductSans-Bold", size: size)
    }
    
    static func medium(_ size: CGFloat)-> Font {
        return Font.custom("ProductSans-Medium", size: size)
    }
    
    static func semibold(_ size: CGFloat)-> Font {
        return Font.custom("ProductSans-Medium", size: size)
    }
    
    static func italic(_ size: CGFloat)-> Font {
        return Font.custom("ProductSans-Italic", size: size)
    }
    
}
