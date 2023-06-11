//
//  Text+.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/11.
//

import Foundation
import SwiftUI

extension Text {
    public func memoFont(size: CGFloat, weight: Font.Weight) -> Text {
        self
            .font(.system(size: size))
            .font(.headline)
            .fontWeight(weight)
    }
}
