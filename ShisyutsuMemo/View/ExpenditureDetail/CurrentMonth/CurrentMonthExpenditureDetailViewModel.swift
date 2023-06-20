//
//  CurrentMonthExpenditureDetailViewModel.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/16.
//

import Foundation
import Combine

final class CurrentMonthExpenditureDetailViewModel: ViewModelObject {

    private let getCurrentMonthUseCase: GetCurrentMonthUseCase
    private let expenditureUseCase: ExpenditureUseCase

    final class Output: OutputObject {
        @Published fileprivate(set) var currentMonth = ""
    }

    final class Binding: BindingObject {
        @Published var showAmountInputSheet = false
        @Published var expenditure: [any ExpenditureProtocol] = []
        @Published var totalExpenditure: Int = 0
    }

    let output: Output
    @BindableObject private(set) var binding: Binding

    init(
        getCurrentMonthUseCase: GetCurrentMonthUseCase,
        expenditureUseCase: ExpenditureUseCase
    ) {
        self.output = Output()
        self.binding = Binding()
        self.getCurrentMonthUseCase = getCurrentMonthUseCase
        self.expenditureUseCase = expenditureUseCase
    }
}

extension CurrentMonthExpenditureDetailViewModel {
    func onAppear() {
        output.currentMonth = getCurrentMonthUseCase.get().description
        binding.expenditure = expenditureUseCase.fetchCurrentMonthExpenditures()
        binding.totalExpenditure = expenditureUseCase.fetchTotalExpenditureForCurrentMonth()
    }

    func onTapExpenseRow() {
        print("タップされたよ")
    }
}
