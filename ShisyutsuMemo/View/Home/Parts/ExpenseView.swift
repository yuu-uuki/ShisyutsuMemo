//
//  ExpenseView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/16.
//

import Foundation
import SwiftUI

struct ExpenseView: View {
    var body: some View {
            HStack {
                leftView()
                Spacer()
                rightView()
            }
            .padding(.vertical, 10)
            .modifier(UnderLine(lineWidth: 2))
    }
}

extension ExpenseView {
    private func leftView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("2023年6月13日")
                .memoFont(size: 12, weight: .medium)
            Text("￥ 200")
                .memoFont(size: 24, weight: .bold)
        }
    }

    private func rightView() -> some View {
        VStack(alignment: .trailing, spacing: 10) {
            Text("電子マネー")
                .memoFont(size: 14, weight: .bold)
                .frame(width: 110, height: 32)
                .background(Color("lightGray"))
                .modifier(CustomCornerRadius(corner: 6, color: .clear))
            Text("衣類、雑貨など")
                .memoFont(size: 12, weight: .medium)
        }
    }
}

struct Expense_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView()
    }
}
