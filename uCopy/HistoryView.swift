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
                    Button("\(indexToShow). \(title.trunc(length: 30))") {
                        print(title)
                    }
                    .keyboardShortcut(KeyEquivalent(Character(UnicodeScalar(0x0030+indexToShow)!)))
                } else {
                    Button("\(indexToShow). \(title.trunc(length: 30))") {
                        print(title)
                    }
                }
            }.id(refreshID)
            Divider()
            Button("Clear History") {
                for item in history {
                    context.delete(item)
                }
                try? context.save()
            }
        }
    }
}
