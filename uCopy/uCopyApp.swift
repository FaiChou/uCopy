//
//  uCopyApp.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/2.
//

import SwiftUI
import HotKey

@main
struct uCopyApp: App {
    @Environment(\.openWindow) var openWindow
//    let hotKey = HotKey(key: .f, modifiers: [.command, .option], keyUpHandler:  {
//        let menu = NSMenu(title: "Popup Menu")
//        let labelItem = NSMenuItem(title: "labelItem", action: nil, keyEquivalent: "")
//        labelItem.isEnabled = false
//        menu.addItem(labelItem)
//        menu.popUp(positioning: nil, at: NSEvent.mouseLocation, in: nil)
//    })
    @StateObject private var dataController = DataController()
    var body: some Scene {
        MainScene()
        Settings {
          SettingView()
        }
        MenuBarExtra("Menu Bar", systemImage: "swift") {
            HistoryView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            Button("Perferences...") {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                for window in NSApplication.shared.windows {
                    if window.title == "uCopy Settings" {
                        window.level = .floating
                    }
                }
            }
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}
