//
//  MenuManager.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/24.
//

import Foundation
import Cocoa

class MenuManager {
    static var moc: NSManagedObjectContext?
    static var historyMenu: NSMenu?
    static var snippetMenu: NSMenu?
    static var historyResults: [History]? = [History]()
    static func popupHistoryMenu() {
        historyMenu = NSMenu(title: "HistoryMenu")
        let labelItem = NSMenuItem(title: "History", action: nil, keyEquivalent: "")
        labelItem.isEnabled = false
        historyMenu!.addItem(labelItem)
        do {
            historyResults = try moc?.fetch(CoreDataHelper.historyFetchRequestWithLimit(size: 20))
            for (index, item) in historyResults!.enumerated() {
                let string = item.title ?? ""
                let title = "\(index+1). \(string.trimingLeadingSpaces().trunc(length: 30))"
                let key = index < 9 ? String(index+1) : ""
                let menuItem = NSMenuItem(
                    title: title,
                    action: #selector(paste),
                    keyEquivalent: key
                )
                menuItem.target = MenuManager.self
                menuItem.representedObject = item
                historyMenu!.addItem(menuItem)
            }
        } catch {
            print("Something wrong!")
        }
        historyMenu!.popUp(positioning: nil, at: NSEvent.mouseLocation, in: nil)
    }
    @objc
    static func paste(_ sender: NSMenuItem) {
        let item = sender.representedObject as! History
        let string = item.title ?? ""
        PasteService.writeToPasteboard(with: string)
        PasteService.paste()
        moc?.delete(item)
        try? moc?.save()
    }
}
