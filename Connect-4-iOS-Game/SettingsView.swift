//
//  SettingsView.swift
//  Connect-4-iOS-Game
//
//  Created by 莊智凱 on 2022/3/19.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("playerPiecesColor") var playerPiecesColor = Color.red
    @AppStorage("computerPiecesColor") var computerPiecesColor = Color.yellow
    @AppStorage("win") var win = 0
    @AppStorage("lose") var lose = 0
    @AppStorage("tie") var tie = 0
    
    @State private var showSafari = false
    
    var body: some View {
        List {
            Section(header: Text("Piece Color")) {
                ColorPicker("Player Piece Color", selection: $playerPiecesColor)
                ColorPicker("Computer Piece Color", selection: $computerPiecesColor)
            }
            Section(header: Text("Reset Score")) {
                Button {
                    win = 0
                    lose = 0
                    tie = 0
                } label: {
                    HStack {
                        Text("Clear Score Data")
                        Spacer()
                        Image(systemName: "arrow.triangle.2.circlepath.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: 25, height: 25)
                    }
                }
            }
            Section(header: Text("About")) {
                Button {
                    showSafari = true
                } label: {
                    HStack {
                        Text("GitHub")
                        Spacer()
                        AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/9919?s=200&v=4")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Color.gray.overlay { ProgressView() }
                        }
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())
                    }
                }
            }
            Section(header: Text("Version 1.0.0")) { }
        }
        .listStyle(.grouped)
        .navigationTitle("Settings")
        .fullScreenCover(isPresented: $showSafari) {
            SafariView(url: URL(string: "https://github.com/5j54d93")!)
        }
    }
}
