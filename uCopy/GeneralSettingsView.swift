//
//  GeneralSettingsView.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/16.
//

import SwiftUI
import AVFoundation

struct GeneralSettingsView: View {
    @AppStorage("uCopy.sound")
    private var selectedSound: SoundNames = .blow
    var body: some View {
        Form {
            Picker("Sound", selection: $selectedSound) {
                ForEach(SoundNames.allCases) { sound in
                    Text(sound.rawValue.capitalized)
                }
            }
        }
        .padding(20)
        .frame(width: 350, height: 100)
        .onChange(of: selectedSound) { newSound in
            NSSound(named: newSound.rawValue.capitalized)?.play()
        }
    }
}

enum SoundNames: String, CaseIterable, Identifiable {
    /**
         Basso.aiff     Bottle.aiff    Funk.aiff      Hero.aiff      Ping.aiff      Purr.aiff      Submarine.aiff
         Blow.aiff      Frog.aiff      Glass.aiff     Morse.aiff     Pop.aiff       Sosumi.aiff    Tink.aiff
     */
    case none, basso, blow, bottle, frog, funk, glass, hero, morse, ping, pop, purr, sosumi, submarine, tink
    var id: Self { self }
}
