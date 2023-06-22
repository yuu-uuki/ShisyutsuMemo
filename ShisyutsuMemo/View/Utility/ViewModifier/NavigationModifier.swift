//
//  NavigationModifier.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/23.
//

import Foundation
import SwiftUI

struct NavigationModifier: ViewModifier {

    let title: String
    @Environment(\.dismiss) var dismiss

    @GestureState private var dragOffset: CGSize = .zero
    private let edgeWidth: CGFloat = 50
    private let baseDragWidth: CGFloat = 30

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.backward.fill")
                                .resizable()
                                .frame(width: 32, height: 24)
                        }
                    ).tint(.black)
                }
            }
            .highPriorityGesture( // スワイプバック対応
                DragGesture().updating(
                    $dragOffset, body: { (value, _, _) in
                        if value.startLocation.x < edgeWidth && value.translation.width > baseDragWidth {
                            dismiss()
                        }
                    }
                )
            )
    }
}
