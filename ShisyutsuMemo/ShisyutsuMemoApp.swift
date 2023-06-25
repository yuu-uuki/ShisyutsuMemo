//
//  ShisyutsuMemoApp.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/10.
//

import SwiftUI

@main
struct ShisyutsuMemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
