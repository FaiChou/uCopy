//
//  HistoryView.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/11.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @FetchRequest(fetchRequest: HistoryView.fetchRequestWithLimit(size: 20)) var history: FetchedResults<History>
    @Environment(\.managedObjectContext) var context
    @State private var refreshID = UUID()

    static func fetchRequestWithLimit(size: Int) -> NSFetchRequest<History> {
        let r: NSFetchRequest<History> = History.fetchRequest()
        r.sortDescriptors = [
            NSSortDescriptor(keyPath: \History.createDate, ascending: false)
        ]
        r.fetchLimit = size
        return r
    }

    var body: some View {
        VStack {
            ForEach(history.indices.prefix(20), id: \.self) { index in
                let title = history[index].title ?? "Unknown"
                let indexToShow = index + 1
                if (index < 9) {
                    let key = KeyEquivalent(Character(UnicodeScalar(0x0030+indexToShow)!))
                    Button("\(indexToShow). \(title.trunc(length: 30))") {
                        self.paste(history[index])
                    }
                    .keyboardShortcut(key)
                } else {
                    Button("\(indexToShow). \(title.trunc(length: 30))") {
                        self.paste(history[index])
                    }
                }
            }.id(refreshID)
            Divider()
            Button("Clear History") {
                let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                try? context.executeAndMergeChanges(using: batchDeleteRequest)
            }
        }
    }
    func paste(_ item: History) {
        let string = item.title ?? ""
        PasteService.writeToPasteboard(with: string)
        PasteService.paste()
        context.delete(item)
        try? context.save()
    }
}
