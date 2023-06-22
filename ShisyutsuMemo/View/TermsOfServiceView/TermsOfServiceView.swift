//
//  TermsOfServiceView.swift
//  ShisyutsuMemo
//
//  Created by yuki.tanaka on 2023/06/23.
//

import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(parseMarkdown(input: TermsOfService.rawText), id: \.self) { element in
                            switch element {
                            case .heading(let text, let level):
                                if level == 1 {
                                    Text(text)
                                        .font(.headline)
                                } else if level == 2 {
                                    Text(text)
                                        .font(.headline)
                                }
                            case .bulletPoint(let text):
                                Text("・" + text)
                            case .normal(let text):
                                Text(text)
                            }
                        }
                    }
                    .padding()
                }
        .modifier(NavigationModifier(title: "利用規約"))
    }
}

extension TermsOfServiceView {
    enum MarkdownElement: Hashable {
        case heading(String, Int)
        case bulletPoint(String)
        case normal(String)
    }

    func parseMarkdown(input: String) -> [MarkdownElement] {
        var elements: [MarkdownElement] = []

        for line in input.split(separator: "\n") {
            let str = String(line)
            if str.starts(with: "# ") {
                elements.append(.heading(String(str.dropFirst(2)), 1))
            } else if str.starts(with: "## ") {
                elements.append(.heading(String(str.dropFirst(3)), 2))
            } else if str.starts(with: "- ") {
                elements.append(.bulletPoint(String(str.dropFirst(2))))
            } else {
                elements.append(.normal(str))
            }
        }

        return elements
    }
}

struct TermsOfServiceView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceView()
    }
}
