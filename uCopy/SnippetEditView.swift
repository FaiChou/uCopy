//
//  SnippetEditView.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/26.
//

import SwiftUI

struct SnippetEditView: View {
    @ObservedObject var item: Snippet
    @State private var name: String = ""
    @State private var content: String = ""
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: Binding($item.name) ?? $name, prompt: Text("Name, Required"))
                TextEditor(text: Binding($item.content) ?? $content)
                    .lineSpacing(5)
            }
            Spacer()
        }
        .padding(.all)
    }
}

