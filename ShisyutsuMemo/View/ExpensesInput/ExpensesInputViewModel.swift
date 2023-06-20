//
//  ExpensesInputViewModel.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/11.
//

import Foundation
import Combine

final class ExpensesInputViewModel: ViewModelObject {

    private let expenditureUseCase: ExpenditureUseCase
    private let updateExpenditure: (any ExpenditureProtocol)?

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
        expenditureUseCase: ExpenditureUseCase,
        updateExpenditure: (any ExpenditureProtocol)?
    ) {
        self.output = Output()
        self.binding = Binding()
        output.paymentType = Payment.type
        self.expenditureUseCase = expenditureUseCase
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
    }

    func fetchExpenditures(_ type: HomeView.ExpensesType) -> [any ExpenditureProtocol] {
        switch type {
        case .current:
            return expenditureUseCase.fetchCurrentMonthExpenditures()
        case .last:
            return expenditureUseCase.fetchLastMonthExpenditures()
        }
    }

    func fetchTotalExpenditures(_ type: HomeView.ExpensesType) -> Int {
        switch type {
        case .current:
            return expenditureUseCase.fetchTotalExpenditureForCurrentMonth()
        case .last:
            return expenditureUseCase.fetchTotalExpenditureForLastMonth()
        }
    }
}
