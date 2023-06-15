//
//  UnderLine.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/16.
//

import Foundation
import SwiftUI

struct UnderLine: ViewModifier {

    let lineWidth: CGFloat

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
            Rectangle()
                .frame(height: lineWidth)
                .foregroundColor(.black)
        }
    }
}
