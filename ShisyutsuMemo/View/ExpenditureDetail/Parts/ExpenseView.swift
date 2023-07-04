//
//  ExpenseView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/16.
//

import Foundation
import SwiftUI

struct ExpenseView: View {

    let expenditure: Expenditure

    @State private var isShowModal: Bool = false
    var completionHandler: () -> Void?

    var body: some View {
            HStack {
                leftView(date: expenditure.date, amount: expenditure.amount)
                Spacer()
                rightView(paymentType: expenditure.paymentType, memo: expenditure.memo)
            }
            .padding(.vertical, 10)
            .modifier(UnderLine(lineWidth: 1))
            .contentShape(Rectangle())
            .onTapGesture {
                isShowModal = true
            }
            .sheet(isPresented: $isShowModal, onDismiss: {
                completionHandler()
            }) {
                ExpensesInputView(
                    viewModel: ExpensesInputViewModel(
                        updateExpenditure: expenditure
                    ),
                    isShowModal: $isShowModal,
                    type: .update)
            }
    }
}

extension ExpenseView {
    private func leftView(date: Date, amount: Int) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(date.formatted)
                .memoFont(size: 12, weight: .medium)
            Text("￥ \(amount)")
                .memoFont(size: 24, weight: .bold)
        }
    }

    private func rightView(paymentType: String, memo: String) -> some View {
        VStack(alignment: .trailing, spacing: 10) {
            Text(paymentType)
                .memoFont(size: 14, weight: .bold)
                .frame(width: 120, height: 28)
                .background(Color("lightGray"))
                .modifier(CustomCornerRadius(corner: 6, color: .clear))
            Text(memo)
                .memoFont(size: 12, weight: .medium)
        }
    }
}
