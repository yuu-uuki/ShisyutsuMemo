//
//  AdCoordinator.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/07/09.
//

import Foundation
import GoogleMobileAds

class AdCoordinator: NSObject, GADFullScreenContentDelegate {
  private var ad: GADInterstitialAd?

  #if DEBUG
  private let adUnitID = "ca-app-pub-3940256099942544/4411468910"
  #else
  private let adUnitID = "ca-app-pub-3940256099942544/4411468910"
  #endif

    func loadAd() {
        GADInterstitialAd.load(
            withAdUnitID: adUnitID,
            request: GADRequest()
        ) { (ad, error) in
            if let error {
                print("😭: 読み込みに失敗しました\(error)")
                return
            }
            print("😍: 読み込みに成功しました")
            self.ad = ad
            self.ad?.fullScreenContentDelegate = self
        }
    }

    func presentAd(from viewController: UIViewController) {
        guard let fullScreenAd = ad else {
            return print("😭: 広告の準備ができていませんでした")
        }
        fullScreenAd.present(fromRootViewController: viewController)
    }

    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("インタースティシャル広告の表示に失敗しました\(error)")
        self.loadAd()
    }

    /// Tells the delegate that the ad presented full screen content.
    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
        print("インタースティシャル広告を表示しました")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("インタースティシャル広告を閉じました")
        self.loadAd()
    }
}
