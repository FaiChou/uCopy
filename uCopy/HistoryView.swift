//
//  HistoryView.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/11.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @FetchRequest(fetchRequest: CoreDataHelper.historyFetchRequestWithLimit(size: 20)) var history: FetchedResults<History>
    @Environment(\.managedObjectContext) var context
    @State private var refreshID = UUID()

    var body: some View {
        VStack {
            ForEach(history.indices.prefix(20), id: \.self) { index in
                let title = history[index].title ?? "Unknown"
                let indexToShow = index + 1
                if (index < 9) {
                    let key = KeyEquivalent(Character(UnicodeScalar(0x0030+indexToShow)!))
                    Button("\(indexToShow). \(title.trimingLeadingSpaces().trunc(length: 30))") {
                        self.paste(history[index])
                    }
                    .keyboardShortcut(key)
                } else {
                    Button("\(indexToShow). \(title.trimingLeadingSpaces().trunc(length: 30))") {
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
        if item.type == PasteboardType.image.rawValue {
            PasteService.writeToPasteboard(with: item.imageData!)
        } else if item.type == PasteboardType.string.rawValue {
            PasteService.writeToPasteboard(with: string)
        }
        context.delete(item)
        PasteService.paste()
        try? context.save()
    }
}

