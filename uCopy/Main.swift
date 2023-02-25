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
            WelcomeView()
                .fixedSize()
        }
        .windowResizability(.contentSize)
    }
}

struct WelcomeView: View {
    @State private var pageIndex = 0
    var body: some View {
        ZStack {
            GeometryReader {proxy in
                HStack(spacing: 0) {
                    Page1()
                        .frame(width: proxy.size.width)
                    Page2()
                        .frame(width: proxy.size.width)
                    Page3()
                        .frame(width: proxy.size.width)
                    Page4()
                        .frame(width: proxy.size.width)
                }
                .offset(x: -(CGFloat(pageIndex)*proxy.size.width))
            }
            .frame(height: 200)
            HStack {
                Button {
                    if pageIndex > 0 {
                        withAnimation {
                            pageIndex -= 1
                        }
                    }
                } label: {
                    Image(systemName: "arrowshape.left")
                        .font(.title)
                        .foregroundColor(pageIndex == 0 ? .gray : .blue)
                }
                .buttonStyle(.plain)
                .padding(.leading, 20)
                .disabled(pageIndex == 0)
                Spacer()
                Button {
                    if pageIndex < 3 {
                        withAnimation {
                            pageIndex += 1
                        }
                    }
                } label: {
                    Image(systemName: "arrowshape.right")
                        .font(.title)
                        .foregroundColor(pageIndex == 3 ? .gray : .blue)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 20)
                .disabled(pageIndex == 3)
            }
        }
        .frame(width: 500, height: 400)
    }
}


struct Page1: View {
    var body: some View {
        VStack {
            Image("icon")
                .resizable()
                .frame(width: 128, height: 128)
            Text("Yet Another Pasteboard Tool")
                .font(.custom("DIN Condensed", size: 25))
                .baselineOffset(-10)
        }
    }
}

struct Page2: View {
    var body: some View {
        VStack {
            Image(systemName: "note.text")
                .resizable()
                .frame(width: 90, height: 80)
                .foregroundColor(.blue)
                .padding(.bottom, 48)
            Text("Clipboard history & Snippet support")
                .font(.custom("DIN Condensed", size: 25))
                .baselineOffset(-10)
        }
    }
}

struct Page3: View {
    var body: some View {
        VStack {
            Image(systemName: "keyboard")
                .resizable()
                .frame(width: 110, height: 80)
                .foregroundColor(.blue)
                .padding(.bottom, 48)
            Text("Customized shortcuts")
                .font(.custom("DIN Condensed", size: 25))
                .baselineOffset(-10)
        }
    }
}

struct Page4: View {
    var body: some View {
        VStack {
            Image(systemName: "speaker.wave.2")
                .resizable()
                .frame(width: 90, height: 80)
                .foregroundColor(.blue)
                .padding(.bottom, 48)
            Text("Sound alert when copy")
                .font(.custom("DIN Condensed", size: 25))
                .baselineOffset(-10)
        }
    }
}

