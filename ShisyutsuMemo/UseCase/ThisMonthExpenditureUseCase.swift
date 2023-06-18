//
//  ThisMonthExpenditureUseCase.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/18.
//

import Foundation

class ThisMonthExpenditureUseCase {
    private let repository: ExpenditureRepositoryProtocol

    init(repository: ExpenditureRepositoryProtocol) {
        self.repository = repository
    }

    func addExpenditure(_ expenditure: ExpenditureProtocol) {
        repository.addExpenditure(expenditure)
    }

    func updateExpenditure(_ expenditure: ExpenditureProtocol, date: Date, amount: Int, paymentType: String, memo: String) {
        repository.updateExpenditure(expenditure, date: date, amount: amount, paymentType: paymentType, memo: memo)
    }

    func deleteExpenditure(_ expenditure: ExpenditureProtocol) {
        repository.deleteExpenditure(expenditure)
    }

    func fetchExpenditures() -> [ExpenditureProtocol] {
        return repository.fetchExpenditures()
    }

    func fetchThisMonthExpenditures() -> [ExpenditureProtocol] {
        repository.fetchThisMonthExpenditures()
    }
}

