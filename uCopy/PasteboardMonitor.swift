//
//  PasteboardMonitor.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/14.
//

import AppKit

enum PasteboardType: String {
    case string
    case image
    case fileUrl
}

class PasteboardData {
    let string: String
    let createDate: Date
    let source: String?
    let type: PasteboardType
    let data: Data?
    init(string: String, createDate: Date, source: String?, type: PasteboardType, data: Data?) {
        self.string = string
        self.createDate = createDate
        self.source = source
        self.type = type
        self.data = data
    }
}

class PasteboardMonitor {
    var timer: Timer!
    let pasteboard = NSPasteboard.general
    var lastChangeCount = 0
    init() {
        self.lastChangeCount = self.pasteboard.changeCount
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: {[weak self] t in
            if self?.lastChangeCount != self?.pasteboard.changeCount {
                self?.lastChangeCount = self?.pasteboard.changeCount ?? 0
                self?.postNotification()
            }
        })
    }
    func terminate() {
        timer.invalidate()
    }
    func postNotification() {
        let frontmostApp = NSWorkspace.shared.frontmostApplication
        if self.pasteboard.pasteboardItems!.count > 1 {
            // not support multiple files right now
            return
        }
//        print(self.pasteboard.availableType(from: self.pasteboard.types ?? []))
        if let fileData = self.pasteboard.data(forType: NSPasteboard.PasteboardType.fileURL) {
            let string = self.pasteboard.string(forType: NSPasteboard.PasteboardType.string)
            let data = PasteboardData(
                string: string ?? "File",
                createDate: Date.now,
                source: frontmostApp?.localizedName,
                type: .fileUrl,
                data: fileData
            )
            NotificationCenter.default.post(name: .NSPasteboardDidChange, object: self.pasteboard, userInfo: ["data": data])
            return
        }
        
        if let imageData = self.pasteboard.data(forType: NSPasteboard.PasteboardType.tiff)
            ?? self.pasteboard.data(forType: NSPasteboard.PasteboardType.png)
            ?? self.pasteboard.data(forType: NSPasteboard.PasteboardType.fileURL) {
            let string = self.pasteboard.string(forType: NSPasteboard.PasteboardType.string)
            let data = PasteboardData(
                string: string ?? "Image",
                createDate: Date.now,
                source: frontmostApp?.localizedName,
                type: .image,
                data: imageData
            )
            NotificationCenter.default.post(name: .NSPasteboardDidChange, object: self.pasteboard, userInfo: ["data": data])
            return
        }

        if let string = self.pasteboard.string(forType: NSPasteboard.PasteboardType.string) {
            let data = PasteboardData(
                string: string,
                createDate: Date.now,
                source: frontmostApp?.localizedName,
                type: .string,
                data: nil
            )
            NotificationCenter.default.post(name: .NSPasteboardDidChange, object: self.pasteboard, userInfo: ["data": data])
        }
    }
}

extension NSNotification.Name {
    public static let NSPasteboardDidChange: NSNotification.Name = .init(rawValue: "pasteboardDidChangeNotification")
}
