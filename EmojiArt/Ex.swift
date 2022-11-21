//
//  Ex.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/21.
//

import Foundation
extension Collection where Element: Identifiable {
    func index(matching element: Element) -> Self.Index? {
        self.firstIndex(where: {$0.id == element.id})
    }
}

extension RangeReplaceableCollection where Element: Identifiable {
    mutating func remove(_ e: Element) {
        if let i = index(matching: e) {
            remove(at: i)
        }
    }
}
