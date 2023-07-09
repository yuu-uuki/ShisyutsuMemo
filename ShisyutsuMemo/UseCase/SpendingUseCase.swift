//
//  SpendingUseCase.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/07/09.
//

import Foundation

enum SpendingUseCaseProvider {
    static func provide() -> SpendingUseCase {
        SpendingUseCaseImpl(
            repository: SpendingRepositoryProvider.provide()
        )
    }
}

protocol SpendingUseCase {
    func showInterstitial() -> Bool
    func incrementSpentTimes()
}

private struct SpendingUseCaseImpl: SpendingUseCase {

    private let repository: SpendingRepository

    init(repository: SpendingRepository) {
        self.repository = repository
    }

    func showInterstitial() -> Bool {
        if repository.getSpentTimes() >= 3 {
            repository.resetSpentTimes()
            return true
        } else {
            return false
        }
    }

    func incrementSpentTimes() {
        repository.incrementSpentTimes()
    }
}
