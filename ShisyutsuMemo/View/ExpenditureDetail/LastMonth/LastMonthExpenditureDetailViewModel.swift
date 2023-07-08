//
//  LastMonthExpenditureDetailViewModel.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/20.
//

import Foundation
import Combine

final class LastMonthExpenditureDetailViewModel: ViewModelObject {

    private let getCurrentMonthUseCase = GetCurrentMonthUseCaseProvider.provide()
    private let expenditureUseCase = ExpenditureUseCaseProvider.provide()
    private let spendingUseCase = SpendingUseCaseProvider.provide()

    final class Output: OutputObject {
        @Published fileprivate(set) var currentMonth = ""
    }

    final class Binding: BindingObject {
        @Published var showAmountInputSheet = false
        @Published var expenditure: [Expenditure] = []
        @Published var totalExpenditure: Int = 0
        @Published var isShowInterstitial = false
    }

    let output: Output
    @BindableObject private(set) var binding: Binding

    init() {
        self.output = Output()
        self.binding = Binding()
    }
}

extension LastMonthExpenditureDetailViewModel {
    func onAppear() {
        output.currentMonth = (getCurrentMonthUseCase.get() - 1).description
        binding.expenditure = expenditureUseCase.fetchLastMonthExpenditures()
        binding.totalExpenditure = expenditureUseCase.fetchTotalExpenditureForLastMonth()
        if spendingUseCase.showInterstitial() {
            binding.isShowInterstitial = true
        }
    }
}

