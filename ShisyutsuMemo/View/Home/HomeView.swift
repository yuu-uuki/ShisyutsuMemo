//
//  HomeView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/10.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel = HomeViewModel(
        getCurrentMonthUseCase: GetCurrentMonthUseCaseProvider.provide()
    )

    var body: some View {
        VStack(spacing: 20) {
            Image("icon_title")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 30)
            Text("\(viewModel.output.currentMonth ?? "")月")
                .memoFont(size: 60, weight: .bold)
            usageAmount()
            Spacer()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .sheet(isPresented: viewModel.$binding.showAmountInputSheet, content: {
            AmountInputView()
        })
        .padding(.top, 50)
    }
}

private extension HomeView {

    private func usageAmount() -> some View {
        HStack(spacing: 20) {
            Text("100")
                .memoFont(size: 80, weight: .bold)
            plusButton()
        }
    }
    private func plusButton() -> some View {
        Button(action: {
            viewModel.binding.showAmountInputSheet.toggle()
        }, label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .foregroundColor(.black)
                .frame(width: 50, height: 50)
        })
        .frame(width: 50, height: 50)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
