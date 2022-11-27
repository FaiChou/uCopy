//
//  SnippetSettingsView.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/26.
//

import SwiftUI
import CoreData

struct SnippetSettingsView: View {
    @FetchRequest(fetchRequest: CoreDataHelper.snippetFetchRequest()) var snippets: FetchedResults<Snippet>
    @Environment(\.managedObjectContext) var context
    @State private var selection: Snippet?
    @State private var refreshID = UUID()
    var body: some View {
        NavigationView {
            VStack {
                List(snippets, id: \.self, selection: $selection) { item in
                    NavigationLink(item.name!) {
                        if selection != nil {
                            SnippetEditView(item: item)
                        } else {
                            Text("Pick a node")
                        }
                    }
                }
                .listStyle(.inset(alternatesRowBackgrounds: true))
                HStack {
                    Button {
                        let newAddedItem = add(name: "New", content: "")
                        selection = newAddedItem
                        refreshID = UUID()
                    } label: {
                        Image(systemName: "plus.rectangle.fill")
                    }
                    Button {
                        if let item = selection {
                            delete(item: item)
                        }
                        selection = .none
                        refreshID = UUID()
                    } label: {
                        Image(systemName: "minus.rectangle.fill")
                    }
                    .disabled(selection == nil)
                }
            }
            Text("Pick a node")
        }
    }
    func delete(item: Snippet) {
        context.delete(item)
        try? context.save()
    }
    func add(name: String, content: String) -> Snippet {
        let item = Snippet(context: context)
        item.id = UUID()
        item.name = name
        item.content = content
        item.createDate = Date.now
        try? context.save()
        return item
    }
}
