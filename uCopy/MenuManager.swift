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
    static var snippetResults: [Snippet]? = [Snippet]()
    static func popupHistoryMenu() {
        historyMenu = NSMenu(title: "HistoryMenu")
        let labelItem = NSMenuItem(title: "History", action: nil, keyEquivalent: "")
        labelItem.isEnabled = false
        historyMenu!.addItem(labelItem)
        do {
            historyResults = try moc?.fetch(CoreDataHelper.historyFetchRequestWithLimit(size: 20))
            for (index, item) in historyResults!.enumerated() {
                let string = item.title ?? ""
                let tooltipString = "\(string)\n\n" + "\(item.source!) \(item.createDate!)"
                let title = "\(index+1). \(string.trimingLeadingSpaces().trunc(length: 30))"
                let key = index < 9 ? String(index+1) : ""
                let menuItem = NSMenuItem(
                    title: title,
                    action: #selector(paste),
                    keyEquivalent: key
                )
                menuItem.target = MenuManager.self
                menuItem.representedObject = item
                menuItem.toolTip = tooltipString // we should use the original formateed string
                historyMenu!.addItem(menuItem)
            }
        } catch {
            print("Something wrong!")
        }
        historyMenu!.popUp(positioning: nil, at: NSEvent.mouseLocation, in: nil)
    }
    static func popupSnippetMenu() {
        snippetMenu = NSMenu(title: "SnippetMenu")
        let labelItem = NSMenuItem(title: "Snippet", action: nil, keyEquivalent: "")
        labelItem.isEnabled = false
        snippetMenu!.addItem(labelItem)
        do {
            snippetResults = try moc?.fetch(CoreDataHelper.snippetFetchRequest())
            for (index, item) in snippetResults!.enumerated() {
                let string = item.name ?? ""
                let content = item.content ?? ""
                let title = "\(index+1). \(string.trimingLeadingSpaces().trunc(length: 30))"
                let key = index < 9 ? String(index+1) : ""
                let menuItem = NSMenuItem(
                    title: title,
                    action: #selector(paste),
                    keyEquivalent: key
                )
                menuItem.target = MenuManager.self
                menuItem.representedObject = item
                menuItem.toolTip = content // we should use the original formateed string
                snippetMenu!.addItem(menuItem)
            }
        } catch {
            print("Something wrong!")
        }
        snippetMenu!.popUp(positioning: nil, at: NSEvent.mouseLocation, in: nil)
    }
    @objc
    static func paste(_ sender: NSMenuItem) {
        if let h = sender.representedObject as? History {
            let string = h.title ?? ""
            if h.type == PasteboardType.image.rawValue {
                PasteService.writeToPasteboard(with: h.data!, forType: .tiff)
            } else if h.type == PasteboardType.string.rawValue {
                PasteService.writeToPasteboard(with: string)
            } else if h.type == PasteboardType.fileUrl.rawValue {
                PasteService.writeToPasteboard(with: h.data!, forType: .fileURL)
            }
            moc?.delete(h)
            PasteService.paste()
        } else if let s = sender.representedObject as? Snippet {
            let string = s.content ?? ""
            PasteService.writeToPasteboard(with: string)
            PasteService.paste()
        }
    }
}
