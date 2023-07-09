//
//  LastMonthExpenditureDetailView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/20.
//

import SwiftUI

struct LastMonthExpenditureDetailView: View {

    @ObservedObject var viewModel = LastMonthExpenditureDetailViewModel()
    private let adViewControllerRepresentable = AdViewControllerRepresentable()
    private var adCoordinator = AdCoordinator()

    var body: some View {
            VStack(spacing: 20) {
                amountView()
                expenditureView(expenditure: viewModel.binding.expenditure)
            }
            .padding(.horizontal, 24)
            .onAppear {
                viewModel.onAppear()
                adCoordinator.loadAd()
            }
            .background {
                adViewControllerRepresentable
                    .frame(width: .zero, height: .zero)
            }
            .onReceive(viewModel.binding.$isShowInterstitial) { isShowFlg in
                if isShowFlg {
                    adCoordinator.presentAd(from: adViewControllerRepresentable.viewController)
                }
            }
    }
}

private extension LastMonthExpenditureDetailView {
    private func amountView() -> some View {
        VStack(spacing: 0) {
            amountHeaderView()
            amountFooterView()
        }
        .modifier(CustomCornerRadius(corner: 8))
    }

    private func amountHeaderView() -> some View {
        ZStack(alignment: .leading) {
            HStack {
                Text("\(viewModel.output.currentMonth)月")
                    .memoFont(size: 20, weight: .bold)
                    .foregroundColor(.white)
                    .frame(height: 42)
                Spacer()
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }

    private func amountFooterView() -> some View {
        HStack(spacing: 24) {
            Text("支出額")
                .memoFont(size: 18, weight: .bold)
            Text("￥ \(viewModel.binding.totalExpenditure)")
                .memoFont(size: 28, weight: .bold)
        }
        .padding(.vertical, 26)
    }

    private func expenditureView(expenditure: [Expenditure]) -> some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(expenditure, id: \.id) { data in
                    ExpenseView(expenditure: data) {
                        viewModel.onAppear()
                    }
                }
            }
        }
    }
}

struct LastMonthExpenditureDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LastMonthExpenditureDetailView()
    }
}
