//
//  CustomCornerRadius.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/16.
//

import Foundation
import SwiftUI

struct CustomCornerRadius: ViewModifier {

    let corner: CGFloat
    let color: Color

    init(corner: CGFloat, color: Color = .black) {
        self.corner = corner
        self.color = color
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: corner)
                    .stroke(color, lineWidth: 2)
            )
            .cornerRadius(corner)
    }
}
