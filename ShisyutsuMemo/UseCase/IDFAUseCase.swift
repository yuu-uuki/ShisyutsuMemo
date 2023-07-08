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
    func getStatus(completion: @escaping () -> Void)
}

private struct IDFAUseCaseImpl: IDFAUseCase {
    private let repository: IDFARepository

    init(repository: IDFARepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<String, Error>) -> Void) {
        repository.getIDFA(completion: completion)
    }

    func getStatus(completion: @escaping () -> Void) {
        switch repository.getIDFAStatus() {
        case .notDetermined:
            completion()
        case .restricted,
             .denied,
             .authorized:
            break
        @unknown default:
            break
        }
    }
}
