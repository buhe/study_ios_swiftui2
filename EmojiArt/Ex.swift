//
//  Ex.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/21.
//

import Foundation
import UIKit

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

extension CGRect {
    var center: CGPoint {
        CGPoint(x: self.midX, y: self.midY)
    }
}
