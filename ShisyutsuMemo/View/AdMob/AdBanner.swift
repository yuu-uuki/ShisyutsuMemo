//
//  AdBanner.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/07/08.
//

import Foundation
import SwiftUI
import GoogleMobileAds

struct AdBanner: UIViewControllerRepresentable {

    private var adSize: GADAdSize {
        return GADAdSizeBanner
    }

    func expectedFrame() -> some View {
        let size = adSize.size
        return frame(width: size.width, height: size.height, alignment: .center)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ GADSimulatorID, "Your-own-device-id" ]
        let view = GADBannerView(adSize: adSize)
        let viewController = UIViewController()
        #if DEBUG
        view.adUnitID = "ca-app-pub-3940256099942544/2934735716" // banner test id
        #else
        view.adUnitID = "ca-app-pub-3390578143891201/7025021154"
        #endif
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame.size = adSize.size
        view.load(GADRequest())
        return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
