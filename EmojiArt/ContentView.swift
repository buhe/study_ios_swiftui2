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
                Color.white.overlay {
                    if let bg = self.viewModel.backgroundImage {
                        Image(uiImage: bg)
                            .position(convertFromEmojiCoordinates((0, 0), in: g))
                    }
                }
                ForEach(viewModel.model.emojis) {
                    e in Text(e.text).font(.system(size: size(for: e))).position(position(for: e, in: g))
                }
            }.onDrop(of: [.plainText, .url], isTargeted: nil) {
                p,l in drop(p, l, g)
            }
        }
    }
    
    func drop(_ p: [NSItemProvider], _ l: CGPoint, _ g: GeometryProxy) ->Bool {
        var found = p.loadObjects(ofType: URL.self) {
            url in viewModel.model.background = .url(url.imageURL)
        }
        if !found {
            found = p.loadObjects(ofType: String.self) {
               text in self.viewModel.model.add(text, at: convert(l, in: g), 40)
           }
        }

        return found
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(location.x),
            y: center.y + CGFloat(location.y)
        )
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
        convertFromEmojiCoordinates((e.x, e.y), in: g)
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
