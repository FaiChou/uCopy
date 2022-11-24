//
//  uCopyApp.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/2.
//

import SwiftUI
import Combine
import AVFoundation

@main
struct uCopyApp: App {
    let monitor = PasteboardMonitor()
    let pub = NotificationCenter.default.publisher(for: .NSPasteboardDidChange)
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("uCopy.sound")
    private var sound: SoundNames = .blow
    @State var pasteboardMonitorCancellable: AnyCancellable?
    @StateObject private var dataController = DataController()
    var body: some Scene {
        MainScene()
        Settings {
            SettingsView()
        }
        MenuBarExtra("Menu Bar", systemImage: "swift") {
            HistoryView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            Button("Perferences...") {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                for window in NSApplication.shared.windows {
                    if window.title == "General" || window.title == "Type" || window.title == "Advanced" {
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
                HotKeyService.setup()
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
