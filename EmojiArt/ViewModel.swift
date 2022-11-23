//
//  ViewModel.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/21.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var model: Model {
        didSet {
            if model.background != oldValue.background {
                fetch()
            }
        }
    }
    @Published var backgroundImage: UIImage?
    
    init() {
        model = Model()
//        model.add("🥰", at: (100,200), 50)
//        model.add("🥹", at: (-100,-200), 100)
    }
    
    func fetch() {
        switch model.background {
        case .url(let url):
            DispatchQueue.global(qos: .userInitiated).async {
                let image = try? Data(contentsOf: url)
                DispatchQueue.main.async { [weak self] in
                    if image != nil {
                        self?.backgroundImage = UIImage(data: image!)
                    }
                }
            }
        default: break
        }
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
