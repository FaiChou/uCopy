//
//  HistoryView.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/11.
//

import SwiftUI
import CoreData

struct HistoryView: View {
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) var history: FetchedResults<History>
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
                Button("\(index+1). \(title.trunc(length: 30))") {
                    print(title)
                }
            }.id(refreshID)
            Divider()
//            Button("Add") {
//                let id = UUID()
//                let title = "\(NSDate.now)"
//                let type = "text"
//                let item = History(context: context)
//                item.id = id
//                item.title = title
//                item.type = type
//                do {
//                    try context.save()
//                    refreshID = UUID()
//                } catch {
//                    let nserror = error as NSError
//                    print("Unresolved error \(nserror), \(nserror.userInfo)")
//                }
//            }
            Button("Clear History") {
                for item in history {
                    context.delete(item)
                }
                try? context.save()
            }
        }
    }
}
