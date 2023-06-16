//
//  ExpenditureDetailViewModel.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/16.
//

import Foundation
import Combine

final class ExpenditureDetailViewModel: ViewModelObject {

    private let getCurrentMonthUseCase: GetCurrentMonthUseCase

    final class Output: OutputObject {
        @Published fileprivate(set) var currentMonth = "6"
    }

    final class Binding: BindingObject {
        @Published var showAmountInputSheet = false
    }

    let output: Output
    @BindableObject private(set) var binding: Binding

    init(getCurrentMonthUseCase: GetCurrentMonthUseCase) {
        self.output = Output()
        self.binding = Binding()
        self.getCurrentMonthUseCase = getCurrentMonthUseCase
    }
}

extension ExpenditureDetailViewModel {
    func onAppear() {
        output.currentMonth = getCurrentMonthUseCase.get().description
    }
}
