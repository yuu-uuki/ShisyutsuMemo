//
//  AmountInputView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/11.
//

import SwiftUI

struct AmountInputView: View {

    @ObservedObject var viewModel = AmountInputViewModel()

    @Environment(\.dismiss) var dismiss

    /// キーボードのフォーカス判定
    @FocusState  var isKeyboardActive: Bool

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 200)
                amountView()
                Spacer()
            }
            .padding(.horizontal, 50)
        }
        .onTapGesture {
            isKeyboardActive = false
        }
    }
}

extension AmountInputView {
    private func amountView() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Text("￥")
                    .memoFont(size: 50, weight: .bold)
                usageAmountInputTextField()
            }
            Rectangle()
                .frame(height: 3)
        }
    }
    private func usageAmountInputTextField() -> some View {
        TextField("", text: viewModel.$binding.usageAmount)
            .font(.system(size: 50))
            .font(.headline)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .focused($isKeyboardActive)
    }
}

struct AmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        AmountInputView()
    }
}
