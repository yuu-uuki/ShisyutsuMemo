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
    func resetSpentTimes()
}

private struct SpendingUseCaseImpl: SpendingUseCase {

    private let repository: SpendingRepository

    init(repository: SpendingRepository) {
        self.repository = repository
    }

    func showInterstitial() -> Bool {
        repository.getSpentTimes() >= 3
    }

    func incrementSpentTimes() {
        repository.incrementSpentTimes()
    }

    func resetSpentTimes() {
        repository.resetSpentTimes()
    }
}
