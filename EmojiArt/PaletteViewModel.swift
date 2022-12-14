//
//  PaletteViewModel.swift
//  EmojiArt
//
//  Created by ้กพ่ณๅ on 2022/11/25.
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
            insert(named: "Vehicles", emojis: "๐๐๐๐๐๐๐๐ป๐๐๐๐๐๐๐โ๏ธ๐ซ๐ฌ๐ฉ๐๐ธ๐ฒ๐๐ถโต๏ธ๐ค๐ฅ๐ณโด๐ข๐๐๐๐๐๐๐๐บ๐")
            insert(named: "Vehicles", emojis: "๐๐๐๐๐๐๐๐ป๐๐๐๐๐๐๐โ๏ธ๐ซ๐ฌ๐ฉ๐๐ธ๐ฒ๐๐ถโต๏ธ๐ค๐ฅ๐ณโด๐ข๐๐๐๐๐๐๐๐บ๐")
            insert(named: "Sports", emojis: "๐โพ๏ธ๐โฝ๏ธ๐พ๐๐ฅ๐โณ๏ธ๐ฅ๐ฅ๐โท๐ณ")
            insert(named: "Music", emojis: "๐ผ๐ค๐น๐ช๐ฅ๐บ๐ช๐ช๐ป")
            insert(named: "Animals", emojis: "๐ฅ๐ฃ๐๐๐๐๐๐๐ฆ๐๐๐๐๐๐ฆ๐ฆ๐ฆ๐ฆ๐ข๐๐ฆ๐ฆ๐ฆ๐๐๐ฆ๐ฆ๐ฆง๐ฆฃ๐๐ฆ๐ฆ๐ช๐ซ๐ฆ๐ฆ๐ฆฌ๐๐ฆ๐๐ฆ๐๐ฉ๐ฆฎ๐๐ฆค๐ฆข๐ฆฉ๐๐ฆ๐ฆจ๐ฆก๐ฆซ๐ฆฆ๐ฆฅ๐ฟ๐ฆ")
            insert(named: "Animal Faces", emojis: "๐ต๐๐๐๐ถ๐ฑ๐ญ๐น๐ฐ๐ฆ๐ป๐ผ๐ปโโ๏ธ๐จ๐ฏ๐ฆ๐ฎ๐ท๐ธ๐ฒ")
            insert(named: "Flora", emojis: "๐ฒ๐ด๐ฟโ๏ธ๐๐๐๐พ๐๐ท๐น๐ฅ๐บ๐ธ๐ผ๐ป")
            insert(named: "Weather", emojis: "โ๏ธ๐คโ๏ธ๐ฅโ๏ธ๐ฆ๐งโ๐ฉ๐จโ๏ธ๐จโ๏ธ๐ง๐ฆ๐โ๏ธ๐ซ๐ช")
            insert(named: "COVID", emojis: "๐๐ฆ?๐ท๐คง๐ค")
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
