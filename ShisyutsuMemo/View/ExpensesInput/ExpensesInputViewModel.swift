//
//  ExpensesInputViewModel.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/11.
//

import Foundation
import Combine

final class ExpensesInputViewModel: ViewModelObject {

    private let expenditureUseCase = ExpenditureUseCaseProvider.provide()
    private let updateExpenditure: Expenditure?
    private let spendingUseCase = SpendingUseCaseProvider.provide()

    final class Output: OutputObject {
        @Published fileprivate(set) var currentMonth: String?
        @Published fileprivate(set) var paymentType: [String] = []
    }

    final class Binding: BindingObject {
        @Published var amount = ""
        @Published var paymentType = ""
        @Published var memoText = ""
        @Published var selectDate: Date = Date()
    }

    let output: Output
    @BindableObject private(set) var binding: Binding

    init(
        updateExpenditure: Expenditure?
    ) {
        self.output = Output()
        self.binding = Binding()
        output.paymentType = Payment.type
        self.updateExpenditure = updateExpenditure
        if let  updateExpenditure {
            binding.amount = updateExpenditure.amount.description
            binding.paymentType = updateExpenditure.paymentType
            binding.memoText = updateExpenditure.memo
            binding.selectDate = updateExpenditure.date
        }
    }
}

extension ExpensesInputViewModel {
    func onTapExpensesButton() {
        expenditureUseCase.addExpenditure(
            date: binding.selectDate,
            amount: Int(binding.amount) ?? 0,
            paymentType: binding.paymentType,
            memo: binding.memoText
        )
        spendingUseCase.incrementSpentTimes()
    }

    func onTapUpdateButton() {
        guard let updateExpenditure else {
            return
        }
        expenditureUseCase.updateExpenditure(
            updateExpenditure,
            date: binding.selectDate,
            amount: Int(binding.amount) ?? 0,
            paymentType: binding.paymentType,
            memo: binding.memoText
        )
        spendingUseCase.incrementSpentTimes()
    }

    func onTapDeleteButton() {
        guard let updateExpenditure else {
            return
        }
        expenditureUseCase.deleteExpenditure(updateExpenditure)
        spendingUseCase.incrementSpentTimes()
    }
}
