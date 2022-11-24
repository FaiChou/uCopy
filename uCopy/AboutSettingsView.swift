//
//  AdvancedSettingsView.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/16.
//

import SwiftUI

struct AboutSettingsView: View {
    var body: some View {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let linkUrlString = "https://github.com/FaiChou/uCopy"
        VStack {
            Image("icon")
                .resizable()
                .frame(width: 128, height: 128)
            Text("uCopy")
                .font(.custom("HeadLineA", size: 25))
            Text("Version: \(appVersion ?? "0.0.1")")
                .padding(.top, 10.0)
            HStack {
                Text("Github:")
                Link(linkUrlString, destination: URL(string: linkUrlString)!)
            }
        }
    }
}

struct AdvancedSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutSettingsView()
    }
}
