//
//  CurrentMonthView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/16.
//

import SwiftUI

struct ExpenditureDetailView: View {

    @ObservedObject var viewModel = ExpenditureDetailViewModel(
        getCurrentMonthUseCase: GetCurrentMonthUseCaseProvider.provide()
    )

    @State private var showModal = false

    let type: HomeView.ExpensesType

    var body: some View {
        VStack(spacing: 40) {
            amountView()
            ExpenseView()
            Spacer()
        }
        .sheet(isPresented: $showModal) {
            ExpensesInputView()
        }
    }
}

private extension ExpenditureDetailView {

    private func amountView() -> some View {
        VStack(spacing: 0) {
            amountHeaderView()
            amountFooterView()
        }
        .modifier(CustomCornerRadius(corner: 8))
        .padding(.horizontal, 20)
    }

    private func amountHeaderView() -> some View {
        ZStack(alignment: .leading) {
            HStack {
                Text("\(viewModel.output.currentMonth)月")
                    .memoFont(size: 20, weight: .bold)
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
            if type == .current {
                Button {
                    showModal = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 36, height: 36)
                }
                .foregroundColor(.black)
            }
        }
        .padding(.vertical, 26)
    }
}

struct CurrentMonthView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenditureDetailView(type: .current)
    }
}
