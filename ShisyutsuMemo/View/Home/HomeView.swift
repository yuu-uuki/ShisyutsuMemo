//
//  HomeView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/10.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel = HomeViewModel(
        getCurrentMonthUseCase: GetCurrentMonthUseCaseProvider.provide()
    )

    @State private var selectedTab = Tab.currentMonth

    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                Image("icon_title")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                amountView()
                expenseHistoryView()
            }
            .padding(.top, 20)
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
}

private extension HomeView {

    private func amountView() -> some View {
        VStack(spacing: 0) {
            amountHeaderView()
            amountFooterView()
        }
        .modifier(CustomCornerRadius(corner: 8))
        .padding(.horizontal, 42)
    }

    private func amountHeaderView() -> some View {
        ZStack(alignment: .leading) {
            HStack {
                Text("\(viewModel.output.currentMonth)月")
                    .memoFont(size: 24, weight: .bold)
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
            Text("￥ 1,000")
                .memoFont(size: 28, weight: .bold)
            Button {
                print("支出入力画面を開く")
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 36, height: 36)
            }
            .foregroundColor(.black)
        }
        .padding(.vertical, 30)
    }

    private func expenseHistoryView() -> some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                ExpenseView()
                    .tag(Tab.currentMonth)

                Text("Second Tab")
                    .tag(Tab.previousMonth)
            }
            .padding(.horizontal, 24)
            Divider()
            CustomTabBar(currentTab: $selectedTab)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
