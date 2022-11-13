//
//  Main.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/5.
//

import SwiftUI

struct MainScene: Scene {
    var body: some Scene {
        WindowGroup(id: "mainscene") {
            Button("close") {
                NSApplication.shared.keyWindow?.close()
            }
            .task {
                NSApp.windows.first?.close()
            }
        }
    }
}
