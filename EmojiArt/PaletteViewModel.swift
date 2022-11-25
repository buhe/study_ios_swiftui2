//
//  PaletteViewModel.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/25.
//

import SwiftUI

struct Palette: Identifiable, Codable {
    var name: String
    var emojis: String
    var id: Int
}
class PaletteViewModel: ObservableObject {
    @Published var palettes = [Palette]() {
        didSet {
            print("watch palettes")
            save()
        }
    }
    func save() {
        let data = try? JSONEncoder().encode(palettes)
        if let data = data {
            UserDefaults.standard.set(data, forKey: "pal")
        }
    }
    func load() {
        if let data = UserDefaults.standard.data(forKey: "pal") ,
            let palettes = try? JSONDecoder().decode([Palette].self, from: data) {
                self.palettes = palettes

        }
        
    }
    init() {
        load()
        if palettes.isEmpty {
            print("using built0in palettes")
            insert(named: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜")
            insert(named: "Vehicles", emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜")
            insert(named: "Sports", emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳")
            insert(named: "Music", emojis: "🎼🎤🎹🪘🥁🎺🪗🪕🎻")
            insert(named: "Animals", emojis: "🐥🐣🐂🐄🐎🐖🐏🐑🦙🐐🐓🐁🐀🐒🦆🦅🦉🦇🐢🐍🦎🦖🦕🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🦙🐐🦌🐕🐩🦮🐈🦤🦢🦩🕊🦝🦨🦡🦫🦦🦥🐿🦔")
            insert(named: "Animal Faces", emojis: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲")
            insert(named: "Flora", emojis: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻")
            insert(named: "Weather", emojis: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️💨☔️💧💦🌊☂️🌫🌪")
            insert(named: "COVID", emojis: "💉🦠😷🤧🤒")
        } else {
            print("succesfully loaded palettes from UserDefaults: \(palettes)")
        }
    }
    
    func insert(named name: String, emojis: String? = nil, at index: Int = 0) {
        let unique = (palettes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let palette = Palette(name: name, emojis: emojis ?? "", id: unique)
        let safeIndex = min(max(index, 0), palettes.count)
        palettes.insert(palette, at: safeIndex)
    }
}
