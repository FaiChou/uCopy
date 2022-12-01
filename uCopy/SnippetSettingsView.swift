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
                List(selection: $selection) {
                    ForEach(snippets, id: \.self) { item in
                        NavigationLink(item.name!) {
                            SnippetEditView(item: item)
                        }
                    }
                    .onMove(perform: move)
                }
                .listStyle(.inset(alternatesRowBackgrounds: true))
                HStack {
                    Button {
                        add(name: "New", content: "")
                        selection = .none
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
    func move(from source: IndexSet, to destination: Int) {
        var revisedItems: [Snippet] = snippets.map{ $0 }
        revisedItems.move(fromOffsets: source, toOffset: destination)
        for reverseIndex in stride(from: revisedItems.count - 1, through: 0, by: -1) {
            revisedItems[reverseIndex].order = Int16(reverseIndex)
        }
        try? context.save()
    }
    func delete(item: Snippet) {
        context.delete(item)
        try? context.save()
    }
    @discardableResult
    func add(name: String, content: String) -> Snippet {
        let item = Snippet(context: context)
        item.id = UUID()
        item.name = name
        item.content = content
        item.createDate = Date.now
        item.order = Int16(snippets.count)
        try? context.save()
        return item
    }
}
