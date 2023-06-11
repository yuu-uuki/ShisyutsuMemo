//
//  GetCurrentMonthUseCase.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/11.
//

import Foundation

enum GetCurrentMonthUseCaseProvider {
    static func provide() -> GetCurrentMonthUseCase {
        GetCurrentMonthUseCaseImpl()
    }
}

protocol GetCurrentMonthUseCase {
    func get() -> Int
}

private class GetCurrentMonthUseCaseImpl: GetCurrentMonthUseCase {
    func get() -> Int {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        return currentMonth
    }
}
