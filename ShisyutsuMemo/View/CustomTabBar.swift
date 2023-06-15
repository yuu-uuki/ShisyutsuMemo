//
//  CustomTabBar.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/16.
//

import Foundation
import SwiftUI

struct CustomTabBar: View {

    @Binding var currentTab: Tab

    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.hashValue) { tab in
                    Button {
                        currentTab = tab
                    } label: {
                        VStack {
                            Image(systemName: tab.symbolName())
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(currentTab == tab ? .black : .gray)
                            Text(tab.label)
                                .memoFont(size: 12, weight: .medium)
                                .foregroundColor(currentTab == tab ? .black : .gray)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 30)
        .padding(.bottom, 10)
        .padding([.horizontal, .top])
    }
}
