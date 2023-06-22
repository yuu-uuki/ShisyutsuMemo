//
//  SettingView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/23.
//

import SwiftUI

struct SettingView: View {

    @ObservedObject var viewModel = SettingViewModel()

    var body: some View {
        Form {
            Section{
                deleteView()
            }
            Section {
                NavigationLink {
                    TermsOfServiceView()
                } label: {
                    Text("利用規約")
                }
            }
        }
        .modifier(NavigationModifier(title: "設定"))
    }
}

extension SettingView {
    private func deleteView() -> some View {
        HStack {
            Text("全データ削除")
                .alert("全てのデータを削除しますか？", isPresented: viewModel.$binding.showDeleteAlert) {
                    Button("OK") {
                        viewModel.delete()
                    }
                    Button("閉じる") {}
                }
                .alert("削除が完了しました", isPresented: viewModel.$binding.showDeleteCompleteAlert) {
                    Button("閉じる") {}
                }
                .alert("削除に失敗しました", isPresented: viewModel.$binding.showDeleteFailureAlert) {
                    Button("閉じる") {}
                }
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.binding.showDeleteAlert = true
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
