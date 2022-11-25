//
//  PaletteView.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/25.
//

import SwiftUI

struct PaletteView: View {
    var paletteViewModel: PaletteViewModel
    @State var selected: Int = 0
    
    var body: some View {
        let current = paletteViewModel.palettes[selected]
        ScrollView(.horizontal) {
            HStack {
                Button {
                    next()
                } label: {
                    Text("Next")
                }.contextMenu {
                    Button {
                        
                    } label: {
                        Text("New")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Edit")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Delete")
                    }
                }
                Text(current.name)
                ForEach(current.emojis.map { (String($0)) }, id: \.self) {
                    e in Text(e).onDrag {
                        NSItemProvider(object: e as NSString)
                    }
                }
                
            }
            
        }.font(.system(size: 40))
    }
    
    func next() {
        selected = (selected + 1) % paletteViewModel.palettes.count
    }
    
//    let test = "🥰🥹😆😄😀😜🥹😇😘😉"
}


struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView(paletteViewModel: PaletteViewModel())
    }
}
