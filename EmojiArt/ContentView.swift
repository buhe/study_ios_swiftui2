//
//  ContentView.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack(spacing: 0) {
            mainBody
            palette
        }
        
    }
    
    var mainBody: some View {
        GeometryReader{
            g in ZStack {
                Color.yellow
                ForEach(viewModel.model.emojis) {
                    e in Text(e.text).font(.system(size: size(for: e))).position(position(for: e, in: g))
                }
            }.onDrop(of: [.plainText], isTargeted: nil) {
                p,l in return p.loadObjects(ofType: String.self) {
                    t in self.viewModel.model.add(t, at: convert(l, in: g), 40)
                }
            }
        }
    }
    
    func size(for e: Model.Emoji) -> CGFloat {
        CGFloat(e.size)
    }
    
    func convert(_ location: CGPoint, in g: GeometryProxy) -> (x: Int, y: Int) {
        let center = g.frame(in: .local).center
        let location = CGPoint(
            x: location.x - center.x,
            y: location.y - center.y
        )
        return (Int(location.x), Int(location.y))
    }
    
    func position(for e: Model.Emoji, in g: GeometryProxy) -> CGPoint {
        let c = g.frame(in: .local).center
        return CGPoint(x: c.x + CGFloat(e.x), y: c.y + CGFloat(e.y))
    }
    
    var palette: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(test.map { (String($0)) }, id: \.self) {
                    e in Text(e).onDrag {
                        NSItemProvider(object: e as NSString)
                    }
                }
                
            }
            
        }.font(.system(size: 40))
    }
    
    let test = "🥰🥹😆😄😀😜🥹😇😘😉"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        ContentView(viewModel: vm)
    }
}
