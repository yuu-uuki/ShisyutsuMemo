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
    func addExpenditure(_ expenditure: any ExpenditureProtocol)
    func updateExpenditure(_ expenditure: any ExpenditureProtocol, date: Date, amount: Int, paymentType: String, memo: String)
    func deleteExpenditure(_ expenditure: any ExpenditureProtocol)
    func fetchExpenditures() -> [any ExpenditureProtocol]
    func fetchCurrentMonthExpenditures() -> [any ExpenditureProtocol]
    func fetchLastMonthExpenditures() -> [any ExpenditureProtocol]
}

final private class ExpenditureRepositoryImpl: ExpenditureRepository {
    private let realm = try! Realm()

    func addExpenditure(_ expenditure: any ExpenditureProtocol) {
        try! realm.write {
            realm.add(expenditure as! Expenditure)
        }
    }

    func updateExpenditure(_ expenditure: any ExpenditureProtocol, date: Date, amount: Int, paymentType: String, memo: String) {
        if let expenditureToUpdate = realm.object(ofType: Expenditure.self, forPrimaryKey: expenditure.id) {
            try! realm.write {
                expenditureToUpdate.date = date
                expenditureToUpdate.amount = amount
                expenditureToUpdate.paymentType = paymentType
                expenditureToUpdate.memo = memo
            }
        }
    }

    func deleteExpenditure(_ expenditure: any ExpenditureProtocol) {
        try! realm.write {
            realm.delete(expenditure as! Expenditure)
        }
    }

    func fetchExpenditures() -> [any ExpenditureProtocol] {
        return Array(realm.objects(Expenditure.self))
    }

    func fetchCurrentMonthExpenditures() -> [any ExpenditureProtocol] {
        let startOfThisMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
        let expenditures = realm.objects(Expenditure.self).filter("date >= %@", startOfThisMonth)
        return Array(expenditures)
    }

    func fetchLastMonthExpenditures() -> [any ExpenditureProtocol] {
        let startOfThisMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
        let startOfLastMonth = Calendar.current.date(byAdding: .month, value: -1, to: startOfThisMonth)!
        let expenditures = realm.objects(Expenditure.self).filter("date >= %@ AND date < %@", startOfLastMonth, startOfThisMonth)
        return Array(expenditures)
    }
}
