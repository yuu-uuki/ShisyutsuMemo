//
//  SplashView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/10.
//

import SwiftUI

struct SplashView: View {
    @State private var isLoading = true

    var body: some View {
        if isLoading {
            Image("icon_app")
                .resizable()
                .frame(width: 300, height: 300)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation {
                            isLoading = false
                        }
                    }
                }
        } else {
            HomeView()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
