// Extensions.swift
// KyvshieldLiteExample
//
// Color, String and view helpers used across the example app.

import SwiftUI
import Foundation

// MARK: - Color hex initialiser

extension Color {
    /// Create a SwiftUI Color from a 6-digit hex string (with or without leading '#').
    /// Example: `Color(hex: "#EF8352")` or `Color(hex: "EF8352")`
    init(hex: String) {
        var cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleaned.hasPrefix("#") { cleaned.removeFirst() }
        guard cleaned.count == 6, let value = UInt64(cleaned, radix: 16) else {
            self = .gray; return
        }
        let r = Double((value >> 16) & 0xFF) / 255
        let g = Double((value >>  8) & 0xFF) / 255
        let b = Double((value      ) & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }

    /// Return a hex string representation of this color (approximate, sRGB).
    var hexString: String {
        let ui = UIColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        ui.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "#%02X%02X%02X",
                      Int(r * 255), Int(g * 255), Int(b * 255))
    }
}

// MARK: - String capitalisation

extension String {
    /// Capitalise the first character only (same behaviour as Flutter's capitalize()).
    func capitalizedFirst() -> String {
        guard !isEmpty else { return self }
        return prefix(1).uppercased() + dropFirst()
    }
}

// MARK: - View modifiers

extension View {
    /// Conditionally apply a view modifier.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool,
                              transform: (Self) -> Content) -> some View {
        if condition { transform(self) } else { self }
    }
}
