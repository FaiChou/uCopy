//
//  HistoryView.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/11.
//

import SwiftUI

struct HistoryView: View {
    @FetchRequest(sortDescriptors: []) var history: FetchedResults<History>
    @Environment(\.managedObjectContext) var context
    @State private var refreshID = UUID()
    var body: some View {
        VStack {
            ForEach(history.indices, id: \.self) { index in
                let title = history[index].title ?? "Unknown"
                Text("\(index+1). \(title)")
            }.id(refreshID)
            Divider()
            Button("Add") {
                let id = UUID()
                let title = "\(NSDate.now)"
                let type = "text"
                let item = History(context: context)
                item.id = id
                item.title = title
                item.type = type
                do {
                    try context.save()
                    refreshID = UUID()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
            Button("Clear History") {
                let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
                let deleteReq = NSBatchDeleteRequest(fetchRequest: fetchReq)
                do {
                    try context.execute(deleteReq)
                } catch {
                    print("Errors on clear history")
                }
            }
        }
    }
}
