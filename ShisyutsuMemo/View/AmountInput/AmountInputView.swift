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

    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                Image("icon_title")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                amountView()
                TabView(selection: $selectedTab) {
                    Text("First Tab")
                        .tabItem {
                            Label("First", systemImage: "1.square.fill")
                        }
                        .tag(0)

                    Text("Second Tab")
                        .tabItem {
                            Label("Second", systemImage: "2.square.fill")
                        }
                        .tag(1)
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 50)
        }
    }
}

extension AmountInputView {
    private func amountView() -> some View {
        VStack(spacing: 0) {
            amountHeaderView()
            amountFooterView()
        }
        .modifier(CustomCornerRadius(corner: 8))
    }

    private func amountHeaderView() -> some View {
        ZStack(alignment: .leading) {
            HStack {
                Text("3月")
                    .memoFont(size: 24, weight: .bold)
                    .foregroundColor(.white)
                    .frame(height: 42)
                Spacer()
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }

    private func amountFooterView() -> some View {
        HStack(spacing: 24) {
            Text("支出額")
                .memoFont(size: 18, weight: .bold)
            Text("￥ 1,000")
                .memoFont(size: 28, weight: .bold)
            Button {
                print("支出入力画面を開く")
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 36, height: 36)
            }
            .foregroundColor(.black)
        }
        .padding(.vertical, 30)
    }
}

struct AmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        AmountInputView()
    }
}
