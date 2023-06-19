//
//  ExpenditureUseCase.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/18.
//

import Foundation

enum ExpenditureUseCaseProvider {
    static func provide() -> ExpenditureUseCase {
        ExpenditureUseCaseImpl(
            repository: ExpenditureRepositoryProvider.provide()
        )
    }
}

protocol ExpenditureUseCase {
    func addExpenditure(date: Date, amount: Int, paymentType: String, memo: String)
    func updateExpenditure(_ expenditure: any ExpenditureProtocol, date: Date, amount: Int, paymentType: String, memo: String)
    func deleteExpenditure(_ expenditure: any ExpenditureProtocol)
    func fetchExpenditures() -> [any ExpenditureProtocol]
    func fetchCurrentMonthExpenditures() -> [any ExpenditureProtocol]
    func fetchLastMonthExpenditures() -> [any ExpenditureProtocol]
}

final private class ExpenditureUseCaseImpl: ExpenditureUseCase {
    private let repository: ExpenditureRepository

    init(repository: ExpenditureRepository) {
        self.repository = repository
    }

    func addExpenditure(date: Date, amount: Int, paymentType: String, memo: String) {
        let newExpenditure = Expenditure()
        newExpenditure.date = date
        newExpenditure.amount = amount
        newExpenditure.paymentType = paymentType
        newExpenditure.memo = memo
        repository.addExpenditure(newExpenditure)
    }

    func updateExpenditure(_ expenditure: any ExpenditureProtocol, date: Date, amount: Int, paymentType: String, memo: String) {
        repository.updateExpenditure(expenditure, date: date, amount: amount, paymentType: paymentType, memo: memo)
    }

    func deleteExpenditure(_ expenditure: any ExpenditureProtocol) {
        repository.deleteExpenditure(expenditure)
    }

    func fetchExpenditures() -> [any ExpenditureProtocol] {
        return repository.fetchExpenditures()
    }

    func fetchCurrentMonthExpenditures() -> [any ExpenditureProtocol] {
        repository.fetchCurrentMonthExpenditures()
    }

    func fetchLastMonthExpenditures() -> [any ExpenditureProtocol] {
        repository.fetchLastMonthExpenditures()
    }
}

