//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/17.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let pvm = PaletteViewModel()
    var body: some Scene {
        
        DocumentGroup(newDocument: { ViewModel() }) { config in
            ContentView(viewModel: config.document, paletteViewModel: pvm)
        }
    }
}
