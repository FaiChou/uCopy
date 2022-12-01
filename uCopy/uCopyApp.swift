//
//  uCopyApp.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/2.
//

import SwiftUI
import Combine
import AVFoundation
import KeyboardShortcuts

@main
struct uCopyApp: App {
    let monitor = PasteboardMonitor()
    let pub = NotificationCenter.default.publisher(for: .NSPasteboardDidChange)
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("uCopy.sound")
    private var sound: SoundNames = .blow
    private var maxSavedLength: Int {
        Int(self.maxSaved) ?? 20
    }
    @AppStorage("uCopy.maxSavedLength")
    private var maxSaved = "20"
    @State var pasteboardMonitorCancellable: AnyCancellable?
    @StateObject private var dataController = DataController()
    var body: some Scene {
        MainScene()
        Settings {
            SettingsView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        MenuBarExtra("Menu Bar", systemImage: "clipboard") {
            HistoryView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            Button("Perferences...") {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                for window in NSApplication.shared.windows {
                    if window.title == "General" || window.title == "Snippet" || window.title == "About" {
                        window.level = .floating
                    }
                }
            }.keyboardShortcut(",")
            Divider()
            Button("Quit") {
                monitor.terminate()
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                AccessibilityService.isAccessibilityEnabled(isPrompt: true)
                KeyboardShortcuts.onKeyDown(for: .historyShortcuts) {
                    MenuManager.popupHistoryMenu()
                }
                KeyboardShortcuts.onKeyDown(for: .snippetShortcuts) {
                    MenuManager.popupSnippetMenu()
                }
                MenuManager.moc = dataController.container.viewContext
                self.pasteboardMonitorCancellable = pub.sink { n in
                    guard let data = n.userInfo?["data"] as? PasteboardData else {
                        return
                    }
                    NSSound(named: sound.rawValue.capitalized)?.play()
                    let context = dataController.container.viewContext
                    let item = History(context: context)
                    item.id = UUID()
                    item.title = data.string
                    item.source = data.source
                    item.createDate = data.createDate
                    do {
                        // if arrives the max length, we should remove the overflow items
                        let historyResults = try context.fetch(CoreDataHelper.historyFetchRequestWithLimit(size: 0))
                        for (index, item) in historyResults.enumerated() {
                            if index >= maxSavedLength {
                                context.delete(item)
                            }
                        }
                        try context.save()
                    } catch {
                        let nserror = error as NSError
                        print("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }
            }
        }
    }
}
