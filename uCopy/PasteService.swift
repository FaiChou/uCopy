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
//        let source = CGEventSource(stateID: .combinedSessionState)
        let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x09, keyDown: true); // cmd-v down
        event1?.flags = CGEventFlags.maskCommand;
        event1?.post(tap: CGEventTapLocation.cghidEventTap);
        let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x09, keyDown: false) // cmd-v up
    //    event2?.flags = CGEventFlags.maskCommand
        event2?.post(tap: CGEventTapLocation.cghidEventTap)
    }
    static func pasteMatchStyle() { // opt-shift-cmd-v
        let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x09, keyDown: true); // opt-shft-cmd-v down
        event1?.flags = [CGEventFlags.maskCommand, CGEventFlags.maskShift, CGEventFlags.maskAlternate]
        event1?.post(tap: CGEventTapLocation.cghidEventTap);
        let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x09, keyDown: false); // opt-shf-cmd-v up
     //   event2?.flags = [CGEventFlags.maskCommand, CGEventFlags.maskShift, CGEventFlags.maskAlternate]
        event2?.post(tap: CGEventTapLocation.cghidEventTap);
    }
    static func pasteResults() { // shift-cmd-v
        let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x09, keyDown: true); // shft-cmd-v down
        event1?.flags = [CGEventFlags.maskCommand, CGEventFlags.maskShift]
        event1?.post(tap: CGEventTapLocation.cghidEventTap);

        let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x09, keyDown: false); // shf-cmd-v up
    //    event2?.flags = [CGEventFlags.maskCommand, CGEventFlags.maskShift];
        event2?.post(tap: CGEventTapLocation.cghidEventTap);
    }
    static func cut() { // cmd-x
        let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x07, keyDown: true); // cmd-x down
        event1?.flags = CGEventFlags.maskCommand;
        event1?.post(tap: CGEventTapLocation.cghidEventTap);

        let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x07, keyDown: false); // cmd-x up
    //    event2?.flags = CGEventFlags.maskCommand;
        event2?.post(tap: CGEventTapLocation.cghidEventTap);
    }
    static func copy() { // cmd-c
        let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: true); // cmd-c down
        event1?.flags = CGEventFlags.maskCommand;
        event1?.post(tap: CGEventTapLocation.cghidEventTap);

        let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: false); // cmd-c up
    //    event2?.flags = CGEventFlags.maskCommand;
        event2?.post(tap: CGEventTapLocation.cghidEventTap);
    }
    static func copyStyle() { // option-cmd-c
        let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: true); // opt-cmd-c down
        event1?.flags = [CGEventFlags.maskCommand, CGEventFlags.maskAlternate];
        event1?.post(tap: CGEventTapLocation.cghidEventTap);
        let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: false); // opt-cmd-c up
        //    event2?.flags = CGEventFlags.maskCommand;
        event2?.post(tap: CGEventTapLocation.cghidEventTap);
    }
    static func pastesStyle() { // option-cmd-v
        let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x07, keyDown: true); // opt-cmd-v down
        event1?.flags = [CGEventFlags.maskCommand, CGEventFlags.maskAlternate];
        event1?.post(tap: CGEventTapLocation.cghidEventTap);
        let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x07, keyDown: false); // opt-cmd-v up
        //    event2?.flags = CGEventFlags.maskCommand;
        event2?.post(tap: CGEventTapLocation.cghidEventTap);
    }
    static func writeToPasteboard(with string: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(string, forType: .string)
    }
}
