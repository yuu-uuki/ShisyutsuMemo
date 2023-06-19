//
//  Expenditure.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/18.
//

import Foundation
import RealmSwift

class Expenditure: Object, ExpenditureProtocol {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var date = Date()
    @objc dynamic var amount = 0
    @objc dynamic var paymentType = ""
    @objc dynamic var memo = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}

protocol ExpenditureProtocol: Identifiable, Hashable {
    var id: String { get }
    var date: Date { get set }
    var amount: Int { get set }
    var paymentType: String { get set }
    var memo: String { get set }
}
