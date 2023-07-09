//
//  HomeView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/10.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel = HomeViewModel()

    @State private var selectedTab = Tab.currentMonth

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                settingView()
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
                .navigationBarHidden(true)
            }
        }
    }
}

private extension HomeView {
    private func expenseHistoryView() -> some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                CurrentMonthExpenditureDetailView()
                    .tag(Tab.currentMonth)

                LastMonthExpenditureDetailView()
                    .tag(Tab.previousMonth)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            Divider()
            CustomTabBar(currentTab: $selectedTab)
        }
    }

    private func settingView() -> some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink {
                    SettingView()
                } label: {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundColor(.black)
                }
            }
            .padding(.top, 28)
            .padding(.horizontal, 24)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
