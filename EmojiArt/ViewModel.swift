//
//  ViewModel.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/21.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var model: Model
    
    init() {
        model = Model()
    }
    
    func move(_ e: Model.Emoji,to offset: CGSize) {
        if let i = model.emojis.index(matching: e) {
            model.emojis[i].x += Int(offset.width)
            model.emojis[i].y += Int(offset.height)
        }
    }
    
    func scale(_ e: Model.Emoji, by scale: CGFloat) {
        if let i = model.emojis.index(matching: e) {
            model.emojis[i].size = Int((CGFloat(model.emojis[i].size) * scale).rounded(.toNearestOrAwayFromZero))
        }
    }
}
