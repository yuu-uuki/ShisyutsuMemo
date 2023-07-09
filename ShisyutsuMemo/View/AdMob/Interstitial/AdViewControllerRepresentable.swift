//
//  AdViewControllerRepresentable.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/07/09.
//

import Foundation
import SwiftUI

struct AdViewControllerRepresentable: UIViewControllerRepresentable {
    let viewController = UIViewController()

    func makeUIViewController(context: Context) -> some UIViewController {
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No implementation needed. Nothing to update.
    }
}
