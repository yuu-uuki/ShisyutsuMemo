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
    func updateExpenditure(_ expenditure: Expenditure, date: Date, amount: Int, paymentType: String, memo: String)
    func deleteExpenditure(_ expenditure: Expenditure)
    func deleteExpendituresTwoMonthsAgo()
    func deleteAllData() -> Result<Void, Error>
    func fetchExpenditures() -> [Expenditure]
    func fetchCurrentMonthExpenditures() -> [Expenditure]
    func fetchLastMonthExpenditures() -> [Expenditure]
    func fetchTotalExpenditureForCurrentMonth() -> Int
    func fetchTotalExpenditureForLastMonth() -> Int
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

    func updateExpenditure(_ expenditure: Expenditure, date: Date, amount: Int, paymentType: String, memo: String) {
        repository.updateExpenditure(expenditure, date: date, amount: amount, paymentType: paymentType, memo: memo)
    }

    func deleteExpenditure(_ expenditure: Expenditure) {
        repository.deleteExpenditure(expenditure)
    }

    func deleteExpendituresTwoMonthsAgo() {
        repository.deleteExpendituresTwoMonthsAgo()
    }

    func deleteAllData() -> Result<Void, Error> {
        do {
            try repository.deleteAllData()
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func fetchExpenditures() -> [Expenditure] {
        return repository.fetchExpenditures()
    }

    func fetchCurrentMonthExpenditures() -> [Expenditure] {
        repository.fetchCurrentMonthExpenditures()
    }

    func fetchLastMonthExpenditures() -> [Expenditure] {
        repository.fetchLastMonthExpenditures()
    }

    func fetchTotalExpenditureForCurrentMonth() -> Int {
        return fetchCurrentMonthExpenditures().reduce(0) { $0 + $1.amount }
    }

    func fetchTotalExpenditureForLastMonth() -> Int {
        return fetchLastMonthExpenditures().reduce(0) { $0 + $1.amount }
    }
}

