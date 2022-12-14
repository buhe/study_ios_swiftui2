//
//  Model.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/21.
//

import Foundation

struct Model: Codable {
    var background: Background = .blank
    var emojis = [Emoji]()
    
    enum Background: Equatable, Codable {
        case blank
        case url(URL)
        case imageData(Data)
        
        func url() -> URL? {
            switch self {
            case .url(let url): return url
            default: return nil
            }
        }
        
        func data() -> Data? {
            switch self {
            case .imageData(let data): return data
            default: return nil
            }
        }
    }
    
    struct Emoji: Identifiable, Codable {
        let text: String
        var x: Int
        var y: Int
        var size: Int
        let id: Int

    }
    var idGen = 0
    mutating func add(_ text: String, at location: (x: Int, y: Int), _ size: Int) {
        idGen += 1
        emojis.append(Emoji(text: text, x: location.x, y: location.y, size: size, id: idGen))
    }
    
    func json() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    init(from: URL) throws {
        let data = try Data(contentsOf: from)
        self = try JSONDecoder().decode(Model.self, from: data)
    }
    
    init() {}
}
