//
//  HomeViewModel.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/11.
//

import Foundation
import Combine

final class HomeViewModel: ViewModelObject {

    private let expenditureUseCase =  ExpenditureUseCaseProvider.provide()

    final class Output: OutputObject {
        @Published fileprivate(set) var currentMonth = ""
    }

    final class Binding: BindingObject {
        @Published var showAmountInputSheet = false
    }

    let output: Output
    @BindableObject private(set) var binding: Binding

    init() {
        self.output = Output()
        self.binding = Binding()
    }
}

extension HomeViewModel {
    func onAppear() {
//        expenditureUseCase.
    }
}
