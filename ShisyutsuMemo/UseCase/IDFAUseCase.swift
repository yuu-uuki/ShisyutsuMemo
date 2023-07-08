//
//  IDFAUseCase.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/07/08.
//

import Foundation

enum IDFAUseCaseProvider {
    static func provide() -> IDFAUseCase {
        IDFAUseCaseImpl(
            repository: IDFARepositoryProvider.provde()
        )
    }
}

protocol IDFAUseCase {
    func execute(completion: @escaping (Result<String, Error>) -> Void)
    func shouldDisplayIDFAPopup() -> Bool
}

private struct IDFAUseCaseImpl: IDFAUseCase {
    private let repository: IDFARepository

    init(repository: IDFARepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<String, Error>) -> Void) {
        repository.getIDFA(completion: completion)
    }

    func shouldDisplayIDFAPopup() -> Bool {
        switch repository.getIDFAStatus() {
        case .notDetermined:
            return true
        case .restricted,
             .denied,
             .authorized:
            return false
        @unknown default:
            return false
        }
    }
}
