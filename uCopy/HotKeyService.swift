//
//  HotKeyService.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/23.
//

import Foundation
import HotKey

class HotKeyService {
    static var clipboardHistoryHotKey: HotKey?
//    static var snippetsHotKey: HotKey?
    static func setup() {
        clipboardHistoryHotKey = HotKey(keyCombo: KeyCombo(key: .c, modifiers: [.command, .option]))
        clipboardHistoryHotKey?.keyDownHandler = {
            print("todo")
        }
    }
}
