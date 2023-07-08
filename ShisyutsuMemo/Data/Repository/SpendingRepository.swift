//
//  SpendingRepository.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/07/09.
//

import Foundation
import SwiftyUserDefaults

enum SpendingRepositoryProvider {
    static func provide() -> SpendingRepository {
        SpendingRepositoryImpl()
    }
}

protocol SpendingRepository {
    func getSpentTimes() -> Int
    func incrementSpentTimes()
    func resetSpentTimes()
}

private struct SpendingRepositoryImpl: SpendingRepository {
    func getSpentTimes() -> Int {
        return Defaults[\.spentTimes]
    }

    func incrementSpentTimes() {
        Defaults[\.spentTimes] += 1
    }

    func resetSpentTimes() {
        Defaults[\.spentTimes] = 0
    }
}
