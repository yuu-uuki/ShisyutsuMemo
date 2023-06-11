//
//  ViewModelObject.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/11.
//

import Combine
import SwiftUI

// MARK: - ViewModelObject
/// ViewModelが準拠するプロトコル
protocol ViewModelObject: ObservableObject {

    associatedtype Binding: BindingObject
    associatedtype Output: OutputObject

    var binding: Binding { get }
    var output: Output { get }
}

extension ViewModelObject where Binding.ObjectWillChangePublisher == ObservableObjectPublisher,
    Output.ObjectWillChangePublisher == ObservableObjectPublisher {

    var objectWillChange: AnyPublisher<Void, Never> {
        Publishers.Merge(binding.objectWillChange, output.objectWillChange).eraseToAnyPublisher()
    }
}

// MARK: - BindingObject
protocol BindingObject: ObservableObject {}

// MARK: - OutputObject
protocol OutputObject: ObservableObject {}

// MARK: - BindableObject
@propertyWrapper
struct BindableObject<T: BindingObject> {

    @dynamicMemberLookup
    struct Wrapper {
        fileprivate let binding: T
        subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<T, Value>) -> Binding<Value> {
            .init(
                get: { self.binding[keyPath: keyPath] },
                set: { self.binding[keyPath: keyPath] = $0 }
            )
        }
    }

    var wrappedValue: T

    var projectedValue: Wrapper {
        Wrapper(binding: wrappedValue)
    }
}

