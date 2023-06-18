//
//  ExpenditureRepository.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/18.
//

import Foundation
import RealmSwift

protocol ExpenditureRepositoryProtocol {
    func addExpenditure(_ expenditure: ExpenditureProtocol)
    func updateExpenditure(_ expenditure: ExpenditureProtocol, date: Date, amount: Int, paymentType: String, memo: String)
    func deleteExpenditure(_ expenditure: ExpenditureProtocol)
    func fetchExpenditures() -> [ExpenditureProtocol]
    func fetchThisMonthExpenditures() -> [ExpenditureProtocol]
    func fetchLastMonthExpenditures() -> [ExpenditureProtocol]
}

class ExpenditureRepository: ExpenditureRepositoryProtocol {
    private let realm = try! Realm()

    func addExpenditure(_ expenditure: ExpenditureProtocol) {
        try! realm.write {
            realm.add(expenditure as! Expenditure)
        }
    }

    func updateExpenditure(_ expenditure: ExpenditureProtocol, date: Date, amount: Int, paymentType: String, memo: String) {
        if let expenditureToUpdate = realm.object(ofType: Expenditure.self, forPrimaryKey: expenditure.id) {
            try! realm.write {
                expenditureToUpdate.date = date
                expenditureToUpdate.amount = amount
                expenditureToUpdate.paymentType = paymentType
                expenditureToUpdate.memo = memo
            }
        }
    }

    func deleteExpenditure(_ expenditure: ExpenditureProtocol) {
        try! realm.write {
            realm.delete(expenditure as! Expenditure)
        }
    }

    func fetchExpenditures() -> [ExpenditureProtocol] {
        return Array(realm.objects(Expenditure.self))
    }

    func fetchThisMonthExpenditures() -> [ExpenditureProtocol] {
        let startOfThisMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
        let expenditures = realm.objects(Expenditure.self).filter("date >= %@", startOfThisMonth)
        return Array(expenditures)
    }

    func fetchLastMonthExpenditures() -> [ExpenditureProtocol] {
        let startOfThisMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
        let startOfLastMonth = Calendar.current.date(byAdding: .month, value: -1, to: startOfThisMonth)!
        let expenditures = realm.objects(Expenditure.self).filter("date >= %@ AND date < %@", startOfLastMonth, startOfThisMonth)
        return Array(expenditures)
    }
}
