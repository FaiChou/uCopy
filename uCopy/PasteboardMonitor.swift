//
//  PasteboardMonitor.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/14.
//

import AppKit

class PasteboardMonitor {
    var timer: Timer!
    var lastChangeCount = 0
    let pasteboard = NSPasteboard.general
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { t in
            if self.lastChangeCount != self.pasteboard.changeCount {
                self.lastChangeCount = self.pasteboard.changeCount
                NotificationCenter.default.post(name: .NSPasteboardDidChange, object: self.pasteboard)
            }
        })
    }
    func terminate() {
        timer.invalidate()
    }
}

extension NSNotification.Name {
    public static let NSPasteboardDidChange: NSNotification.Name = .init(rawValue: "pasteboardDidChangeNotification")
}
