//
//  AdvancedSettingsView.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/16.
//

import SwiftUI

struct AboutSettingsView: View {
    var body: some View {
        VStack {
            Image("icon")
                .resizable()
                .frame(width: 128, height: 128)
        }
    }
}

struct AdvancedSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutSettingsView()
    }
}
