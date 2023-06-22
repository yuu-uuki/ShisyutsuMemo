//
//  SettingViewModel.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/23.
//

import Foundation
import Combine

final class SettingViewModel: ViewModelObject {

    private let expenditureUseCase = ExpenditureUseCaseProvider.provide()

    final class Output: OutputObject {
        @Published fileprivate(set) var currentMonth = ""
    }

    final class Binding: BindingObject {
        @Published var showDeleteAlert = false
        @Published var showDeleteCompleteAlert = false
        @Published var showDeleteFailureAlert = false
    }

    let output: Output
    @BindableObject private(set) var binding: Binding

    init() {
        self.output = Output()
        self.binding = Binding()
    }
}

extension SettingViewModel {
    func delete() {
        let result = expenditureUseCase.deleteAllData()
        switch result {
        case .success():
            binding.showDeleteCompleteAlert = true
        case .failure:
            binding.showDeleteFailureAlert = true
        }
    }
}
