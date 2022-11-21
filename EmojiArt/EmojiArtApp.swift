//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/17.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let vm = ViewModel()
    var body: some Scene {
        
        WindowGroup {
            ContentView(viewModel: vm)
        }
    }
}
