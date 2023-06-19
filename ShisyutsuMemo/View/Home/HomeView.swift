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
            VStack(spacing: 40) {
                Image("icon_title")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                expenseHistoryView()
            }
            .padding(.top, 20)
            .onAppear {
                viewModel.onAppear()
            }
    }
}

private extension HomeView {

    private func expenseHistoryView() -> some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                ExpenditureDetailView(type: .current)
                    .tag(Tab.currentMonth)

                ExpenditureDetailView(type: .previous)
                    .tag(Tab.previousMonth)
            }
            .accentColor(.black)
            .padding(.horizontal, 24)
            .padding(.bottom, 0)
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
