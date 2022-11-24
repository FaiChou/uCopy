//
//  AccessibilityService.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/23.
//

import Foundation
import Cocoa

final class AccessibilityService {}

// MARK: - Permission
extension AccessibilityService {
    @discardableResult
    static func isAccessibilityEnabled(isPrompt: Bool) -> Bool {
        // Accessibility permission is required for paste command from macOS 10.14 Mojave.
        // For macOS 10.14 and later only, check accessibility permission at startup and paste
        guard #available(macOS 10.14, *) else { return true }

        let checkOptionPromptKey = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String
        let opts = [checkOptionPromptKey: isPrompt] as CFDictionary
        return AXIsProcessTrustedWithOptions(opts)
    }

    static func showAccessibilityAuthenticationAlert() {
        let alert = NSAlert()
        alert.messageText = "Please allow Accessibility"
        alert.informativeText = "To do this action please allow Accessibility in Security Privacy preferences located in System Preferences"
        alert.addButton(withTitle: "Open System Preferences")
        NSApp.activate(ignoringOtherApps: true)

        if alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn {
            guard !openAccessibilitySettingWindow() else { return }
            isAccessibilityEnabled(isPrompt: true)
        }
    }

    static func openAccessibilitySettingWindow() -> Bool {
        guard let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") else { return false }
        return NSWorkspace.shared.open(url)
    }
}
