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
    private let idfaUseCase = IDFAUseCaseProvider.provide()

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
        // ２か月前のデータは削除
        expenditureUseCase.deleteExpendituresTwoMonthsAgo()
        idfaUseCase.getStatus {
            self.fetchIDFA()
        }
    }
}

extension HomeViewModel {
    private func fetchIDFA() {
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
