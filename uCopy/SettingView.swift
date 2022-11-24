//
//  SettingView.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/12.
//

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, advanced
    }
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
            AboutSettingsView()
                .tabItem {
                    Label("About", systemImage: "aqi.medium")
                }
                .tag(Tabs.advanced)
        }
        .padding(20)
        .frame(width: 500, height: 300)
    }
}
