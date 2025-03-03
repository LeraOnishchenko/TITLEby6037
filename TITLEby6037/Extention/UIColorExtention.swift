//
//  UIColorExtention.swift
//  TITLEby6037
//
//  Created by lera on 03.03.2025.
//

import SwiftUI

extension Color {
    init?(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hex.hasPrefix("#") {
            hex.removeFirst()
        }
        if hex.count == 6 {
            hex.append("FF")
        }
        guard hex.count == 8, let intVal = UInt64(hex, radix: 16) else {
            return nil
        }
        
        let r = Double((intVal & 0xFF000000) >> 24) / 255.0
        let g = Double((intVal & 0x00FF0000) >> 16) / 255.0
        let b = Double((intVal & 0x0000FF00) >> 8) / 255.0
        let a = Double(intVal & 0x000000FF) / 255.0
        
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
