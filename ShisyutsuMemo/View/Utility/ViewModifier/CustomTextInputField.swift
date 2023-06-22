//
//  CustomTextInputField.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/17.
//

import Foundation
import SwiftUI

struct CustomTextInputField: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 8) // 枠線の追加
                .stroke(Color.gray, lineWidth: 1)
            )
    }
}
