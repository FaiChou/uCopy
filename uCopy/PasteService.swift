//
//  PasteService.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/23.
//

import Foundation
import CoreGraphics
import AppKit

class PasteService {
    static func paste() {
        guard AccessibilityService.isAccessibilityEnabled(isPrompt: false) else {
            AccessibilityService.showAccessibilityAuthenticationAlert()
            return
        }
        let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x09, keyDown: true); // cmd-v down
        event1?.flags = CGEventFlags.maskCommand;
        event1?.post(tap: CGEventTapLocation.cghidEventTap);
        let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x09, keyDown: false) // cmd-v up
        event2?.post(tap: CGEventTapLocation.cghidEventTap)
    }
    static func writeToPasteboard(with string: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(string, forType: .string)
    }
}
