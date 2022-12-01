//
//  GeneralSettingsView.swift
//  uCopy
//
//  Created by 周辉 on 2022/11/16.
//

import SwiftUI
import AVFoundation
import LaunchAtLogin
import KeyboardShortcuts
import Combine

struct GeneralSettingsView: View {
    @AppStorage("uCopy.sound")
    private var selectedSound: SoundNames = .blow
    @AppStorage("uCopy.maxSavedLength")
    private var maxSavedLength = "20"
    @State private var showingPopover = false
    var body: some View {
        Form {
            Section {
                LaunchAtLogin.Toggle("Launch at login")
            }
            .padding(.bottom)
            Section {
                KeyboardShortcuts.Recorder("History Shortcuts:", name: .historyShortcuts)
                KeyboardShortcuts.Recorder("Snippet Shortcuts:", name: .snippetShortcuts)
            }
            .padding(.bottom)
            Section {
                Picker("Sound", selection: $selectedSound) {
                    ForEach(SoundNames.allCases) { sound in
                        Text(sound.rawValue.capitalized)
                    }
                }
            }
            .padding(.bottom)
            Section {
                HStack {
                    TextField("Max saved:", text: $maxSavedLength)
                        .onReceive(Just(maxSavedLength)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.maxSavedLength = filtered
                            }
                        }
                    Button {
                        showingPopover = true
                    } label: {
                        Image(systemName: "questionmark")
                    }
                    .buttonStyle(.plain)
                    .popover(isPresented: $showingPopover) {
                        Text("Excess items will be deleted automatically")
                            .font(.headline)
                            .padding()
                    }
                }
            }
            .padding(.bottom)
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

extension KeyboardShortcuts.Name {
    static let historyShortcuts = Self("historyShortcuts",
                                       default: .init(.c, modifiers: [.command, .option]))
    static let snippetShortcuts = Self("snippetShortcuts",
                                       default: .init(.x, modifiers: [.command, .option]))
}
