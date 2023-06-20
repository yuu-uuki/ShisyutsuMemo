//
//  CurrentMonthView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/16.
//

import SwiftUI

struct CurrentMonthExpenditureDetailView: View {

    @ObservedObject var viewModel = CurrentMonthExpenditureDetailViewModel(
        getCurrentMonthUseCase: GetCurrentMonthUseCaseProvider.provide(),
        expenditureUseCase: ExpenditureUseCaseProvider.provide()
    )

    @State private var isShowModal = false

    let type: HomeView.ExpensesType

    var body: some View {
        VStack(spacing: 20) {
            amountView()
            expenditureView(expenditure: viewModel.binding.expenditure)
        }
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.onAppear()
        }
        .sheet(isPresented: $isShowModal, onDismiss: {
            viewModel.onAppear()
        }) {
            ExpensesInputView(
                viewModel: ExpensesInputViewModel(
                    expenditureUseCase: ExpenditureUseCaseProvider.provide(),
                    updateExpenditure: nil),
                isShowModal: $isShowModal,
                type: .input
            )
        }
    }
}

private extension CurrentMonthExpenditureDetailView {
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
            Text("￥ \(viewModel.binding.totalExpenditure)")
                .memoFont(size: 28, weight: .bold)
            if type == .current {
                Button {
                    isShowModal = true
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

    private func expenditureView(expenditure: [any ExpenditureProtocol]) -> some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(expenditure, id: \.id) { data in
                    ExpenseView(expenditure: data) {
                        viewModel.onAppear()
                    }
                }
            }
        }
    }
}

struct CurrentMonthView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentMonthExpenditureDetailView(type: .current)
    }
}
