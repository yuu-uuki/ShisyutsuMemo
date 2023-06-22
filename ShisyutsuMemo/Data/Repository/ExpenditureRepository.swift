//
//  ExpenditureRepository.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/18.
//

import Foundation
import RealmSwift

enum ExpenditureRepositoryProvider {
    static func provide() -> ExpenditureRepository {
        ExpenditureRepositoryImpl()
    }
}

protocol ExpenditureRepository {
    func addExpenditure(_ expenditure: Expenditure)
    func updateExpenditure(_ expenditure: Expenditure, date: Date, amount: Int, paymentType: String, memo: String)
    func deleteExpenditure(_ expenditure: Expenditure)
    func deleteExpendituresTwoMonthsAgo()
    func deleteAllData() throws
    func fetchExpenditures() -> [Expenditure]
    func fetchCurrentMonthExpenditures() -> [Expenditure]
    func fetchLastMonthExpenditures() -> [Expenditure]
}

final private class ExpenditureRepositoryImpl: ExpenditureRepository {
    private let realm = try! Realm()

    func addExpenditure(_ expenditure: Expenditure) {
        try! realm.write {
            realm.add(expenditure)
        }
    }

    func updateExpenditure(_ expenditure: Expenditure, date: Date, amount: Int, paymentType: String, memo: String) {
        if let expenditureToUpdate = realm.object(ofType: Expenditure.self, forPrimaryKey: expenditure.id) {
            try! realm.write {
                expenditureToUpdate.date = date
                expenditureToUpdate.amount = amount
                expenditureToUpdate.paymentType = paymentType
                expenditureToUpdate.memo = memo
            }
        }
    }

    func deleteExpenditure(_ expenditure: Expenditure) {
        try! realm.write {
            realm.delete(expenditure)
        }
    }

    func deleteExpendituresTwoMonthsAgo() {
        let realm = try! Realm()

        let twoMonthsAgo = Calendar.current.date(byAdding: .month, value: -2, to: Date())!
        let startOfTwoMonthsAgo = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: twoMonthsAgo))!

        let oldExpenditures = realm.objects(Expenditure.self).filter("date < %@", startOfTwoMonthsAgo)

        try! realm.write {
            realm.delete(oldExpenditures)
        }
    }

    func deleteAllData() throws {
        let realm = try Realm()

        try realm.write {
            realm.deleteAll()
        }
    }

    func fetchExpenditures() -> [Expenditure] {
        return Array(realm.objects(Expenditure.self))
    }

    func fetchCurrentMonthExpenditures() -> [Expenditure] {
        let startOfThisMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
        let expenditures = realm.objects(Expenditure.self).filter("date >= %@", startOfThisMonth)
        return Array(expenditures)
    }

    func fetchLastMonthExpenditures() -> [Expenditure] {
        let startOfThisMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
        let startOfLastMonth = Calendar.current.date(byAdding: .month, value: -1, to: startOfThisMonth)!
        let expenditures = realm.objects(Expenditure.self).filter("date >= %@ AND date < %@", startOfLastMonth, startOfThisMonth)
        return Array(expenditures)
    }
}
