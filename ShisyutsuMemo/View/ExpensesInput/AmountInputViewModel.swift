//
//  AmountInputViewModel.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/11.
//

import Foundation
import Combine

final class AmountInputViewModel: ViewModelObject {

    final class Output: OutputObject {
        @Published fileprivate(set) var currentMonth: String?
        @Published fileprivate(set) var paymentType: [String] = []
    }

    final class Binding: BindingObject {
        @Published var usageAmount = ""
        @Published var amount = ""
        @Published var paymentType = ""
        @Published var memoText = ""
        @Published var selectDate: Date = Date()
    }

    let output: Output
    @BindableObject private(set) var binding: Binding

    init() {
        self.output = Output()
        self.binding = Binding()
        output.paymentType = Payment.type
    }
}
