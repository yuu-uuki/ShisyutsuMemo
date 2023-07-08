//
//  CurrentMonthExpenditureDetailViewModel.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/16.
//

import Foundation
import Combine

final class CurrentMonthExpenditureDetailViewModel: ViewModelObject {

    private let getCurrentMonthUseCase = GetCurrentMonthUseCaseProvider.provide()
    private let expenditureUseCase = ExpenditureUseCaseProvider.provide()
    private let idfaUseCase = IDFAUseCaseProvider.provide()

    final class Output: OutputObject {
        @Published fileprivate(set) var currentMonth = ""
    }

    final class Binding: BindingObject {
        @Published var showAmountInputSheet = false
        @Published var expenditure: [Expenditure] = []
        @Published var totalExpenditure: Int = 0
        @Published var isShowModal = false
        @Published var showIDFAPopupView = false
    }

    let output: Output
    @BindableObject private(set) var binding: Binding

    init() {
        self.output = Output()
        self.binding = Binding()
    }
}

extension CurrentMonthExpenditureDetailViewModel {
    func onAppear() {
        output.currentMonth = getCurrentMonthUseCase.get().description
        binding.expenditure = expenditureUseCase.fetchCurrentMonthExpenditures()
        binding.totalExpenditure = expenditureUseCase.fetchTotalExpenditureForCurrentMonth()
        if idfaUseCase.shouldDisplayIDFAPopup() {
            self.binding.showIDFAPopupView = true
        }
    }

    func fetchIDFA() {
        idfaUseCase.execute { result in
            switch result {
            case .success(let idfa):
                print(idfa)
            case .failure(let error):
                print(error)
            }
        }
    }
}
