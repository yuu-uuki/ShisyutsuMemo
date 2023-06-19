//
//  Date+.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/20.
//

import Foundation

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter.string(from: self)
    }
}
