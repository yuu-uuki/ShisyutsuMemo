//
//  IDFARepository.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/07/08.
//

import Foundation
import AppTrackingTransparency
import AdSupport

enum IDFARepositoryProvider {
    static func provde() -> IDFARepository {
        IDFARepositoryImpl()
    }
}

protocol IDFARepository {
    func getIDFA(completion: @escaping (Result<String, Error>) -> Void)
    func getIDFAStatus() -> ATTrackingManager.AuthorizationStatus
}

private struct IDFARepositoryImpl: IDFARepository {
    func getIDFA(completion: @escaping (Result<String, Error>) -> Void) {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                // IDFA access granted
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                completion(.success(idfa))
            case .denied:
                // IDFA access denied
                completion(.failure(IDFAError.accessDenied))
            case .restricted, .notDetermined:
                completion(.failure(IDFAError.accessRestrictedOrNotDetermined))
            @unknown default:
                completion(.failure(IDFAError.unknownAuthorizationStatus))
            }
        }
    }

    func getIDFAStatus() -> ATTrackingManager.AuthorizationStatus {
        ATTrackingManager.trackingAuthorizationStatus
    }
}

enum IDFAError: Error {
    case accessDenied
    case accessRestrictedOrNotDetermined
    case unknownAuthorizationStatus
}
