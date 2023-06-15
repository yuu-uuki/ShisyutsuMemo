//
//  Tab.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/16.
//

import Foundation

enum Tab: CaseIterable {
    case currentMonth
    case previousMonth
}

// MARK: - SF Symbols Name
extension Tab {

    var label: String {
        switch self {
        case .currentMonth:
            return "今月"
        case .previousMonth:
            return "先月"
        }
    }

    func symbolName() -> String {
        switch self {
        case .currentMonth:
            return "calendar"
        case .previousMonth:
            return "calendar.badge.minus"
        }
    }
}
