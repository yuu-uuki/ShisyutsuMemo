//
//  ExpensesInputView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/11.
//

import SwiftUI

struct ExpensesInputView: View {

    @ObservedObject var viewModel = ExpensesInputViewModel(
        expenditureUseCase: ExpenditureUseCaseProvider.provide()
    )

    @State private var showExpensesAlert = false
    @State private var showUpdateAlert = false

    @Binding var expenditureBinding: [any ExpenditureProtocol]
    @Binding var totalExpenditure: Int
    @Binding var isShowModal: Bool
    let type: HomeView.ExpensesType

    /// グリッドの列の設定
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 2)

    /// 選択されたアイテムを管理する@State変数
    @State private var selectedItem: String?

    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                amountInput()
                paymentType()
                dateInput()
                memoInput()
                footerButton()
            }
            .padding(.top, 40)
            .padding(.horizontal, 30)
        }
        .onTapGesture {
            dismissKeyboard()
        }
    }
}

extension ExpensesInputView {
    private func amountInput() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("金額")
                .memoFont(size: 16, weight: .bold)
            TextField("", text: viewModel.$binding.amount)
                .keyboardType(.numberPad) // 数字キーボードの表示
                .modifier(CustomTextInputField())
        }
    }

    private func paymentType() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("支払種別")
                .memoFont(size: 16, weight: .bold)
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.output.paymentType, id: \.self) { paymentType in
                    Button {
                        selectedItem = paymentType
                        viewModel.binding.paymentType = paymentType
                    } label: {
                        Text(paymentType)
                            .memoFont(size: 14, weight: .bold)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(selectedItem == paymentType ? .white : .black)
                            .background(selectedItem == paymentType ? Color.black : Color("lightGray"))
                            .modifier(CustomCornerRadius(corner: 4, color: .clear))

                    }
                }
            }
        }
    }

    private func dateInput() -> some View {
        HStack {
            Text("日付")
                .memoFont(size: 16, weight: .bold)
            Spacer()
            DatePicker("", selection: viewModel.$binding.selectDate, displayedComponents: [.date])
                .environment(\.locale, Locale(identifier: "ja_JP"))
        }
    }

    private func memoInput() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("メモ")
                .memoFont(size: 16, weight: .bold)
            TextEditor(text: viewModel.$binding.memoText)
                        .frame(height: 80)
                        .modifier(CustomTextInputField())
        }
    }

    private func footerButton() -> some View {
        if type == .current {
            return AnyView(expensesButton())
        } else {
            return AnyView(updateButton())
        }
    }

    private func expensesButton() -> some View {
        Button {
            showExpensesAlert = true
        } label: {
            Text("支出")
                .memoFont(size: 18, weight: .bold)
                .frame(width: 160, height: 50)
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(8)
        }
        .padding(.top, 12)
        .alert("支出しますか？", isPresented: $showExpensesAlert) {
            Button("OK") {
                viewModel.onTapExpensesButton()
                self.expenditureBinding = viewModel.fetchExpenditures(type)
                self.totalExpenditure = viewModel.fetchTotalExpenditures(type)
                isShowModal = false
            }
            Button("閉じる") {}
        }
    }

    private func updateButton() -> some View {
        Button {
            showUpdateAlert = true
        } label: {
            Text("更新")
                .memoFont(size: 18, weight: .bold)
                .frame(width: 160, height: 50)
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(8)
        }
        .padding(.top, 12)
        .alert("更新しますか？", isPresented: $showExpensesAlert) {
            Button("OK") {
                print("押されたよ")
            }
            Button("閉じる") {}
        }
    }
}

extension ExpensesInputView {
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
