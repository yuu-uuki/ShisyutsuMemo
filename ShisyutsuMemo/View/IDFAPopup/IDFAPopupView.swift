//
//  IDFAPopupView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/07/08.
//

import SwiftUI

struct IDFAPopupView: View {

    @Binding var isPresented: Bool
    let isEnabledToCloseByBackgroundTap = true
    let completion: () -> Void

    var body: some View {
        GeometryReader { geometry in
            let dialogWidth = geometry.size.width * 0.85

                VStack(spacing: 20) {
                    popupView()
                        .cornerRadius(10)
                        .shadow(radius: 5)

                    closeButton()
                        .cornerRadius(10)
                        .frame(width: dialogWidth * 0.85)
                        .shadow(radius: 5)
                }
                .frame(width: dialogWidth)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }

    }
}

extension IDFAPopupView {

    private func popupView() -> some View {
        VStack(spacing: 0) {
            popupTitleView()
            popupDescriptionView()
        }
        .background(Color.white)
    }

    private func popupTitleView() -> some View {
        Text("トラッキングについて")
            .memoFont(size: 20, weight: .bold)
            .padding(.vertical, 10)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(Color.black)
    }

    private func popupDescriptionView() -> some View {
        VStack(spacing: 16) {
            Text("支出メモ")
                .memoFont(size: 16, weight: .semibold)
            +
            Text("はより良い体験を提供するため、広告をパーソナライズするためにデータを使います。")
                .memoFont(size: 16, weight: .regular)

            Text("次に表示されるリクエストで「許可する」を選んでください。\n許可しない場合でも、アプリは動作しますが広告は一般的なものになります。")
                .memoFont(size: 16, weight: .regular)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
    }

    private func closeButton() -> some View {
        Button {
            withAnimation {
                self.isPresented = false
                completion()
            }
        } label: {
            Text("閉じる")
                .memoFont(size: 16, weight: .bold)
                .foregroundColor(.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
        }
        .background(Color.black)
    }
}
