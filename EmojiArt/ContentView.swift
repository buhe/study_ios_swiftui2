//
//  ContentView.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var paletteViewModel: PaletteViewModel
    @State var zoomScale: CGFloat = 1
    var body: some View {
        VStack(spacing: 0) {
            mainBody
            PaletteView(paletteViewModel: paletteViewModel)
        }
        
    }
    
    var mainBody: some View {
        GeometryReader{
            g in ZStack {
                Color.white.overlay {
                    if let bg = self.viewModel.backgroundImage {
                        Image(uiImage: bg)
                            .scaleEffect(zoomScale)
                            .position(convertFromEmojiCoordinates((0, 0), in: g))
                            
                    }
                }
                    .gesture(TapGesture(count: 1).onEnded {
                        withAnimation {
                            zoomToFit(viewModel.backgroundImage, in: g.size)
                        }
                    })
                ForEach(viewModel.model.emojis) {
                    e in Text(e.text).font(.system(size: size(for: e))).scaleEffect(zoomScale).position(position(for: e, in: g))
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
               text in self.viewModel.model.add(text, at: convert(l, in: g), Int(CGFloat(40) / zoomScale))
           }
        }

        return found
    }
    
    func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            
            zoomScale = min(hZoom, vZoom)
            print("zoom is \(zoomScale)")
        }
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        let ret = CGPoint(
            x: center.x + CGFloat(location.x) * zoomScale,
            y: center.y + CGFloat(location.y) * zoomScale
        )
        print("from is \(ret)")
        return ret
    }
    
    func size(for e: Model.Emoji) -> CGFloat {
        CGFloat(e.size)
    }
    
    func convert(_ location: CGPoint, in g: GeometryProxy) -> (x: Int, y: Int) {
        let center = g.frame(in: .local).center
        print("au is \(location)")
        let location = CGPoint(
            x: (location.x - center.x) / zoomScale,
            y: (location.y - center.y) / zoomScale
        )
        let ret = (Int(location.x), Int(location.y))
        print("to is \(ret)")
        return ret
    }
    
    func position(for e: Model.Emoji, in g: GeometryProxy) -> CGPoint {
        convertFromEmojiCoordinates((e.x, e.y), in: g)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        let pvm = PaletteViewModel()
        ContentView(viewModel: vm, paletteViewModel: pvm)
    }
}
