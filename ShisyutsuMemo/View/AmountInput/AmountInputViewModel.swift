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
    }

    final class Binding: BindingObject {
        @Published var usageAmount = ""
    }

    let output: Output
    @BindableObject private(set) var binding: Binding

    init() {
        self.output = Output()
        self.binding = Binding()
    }
}
