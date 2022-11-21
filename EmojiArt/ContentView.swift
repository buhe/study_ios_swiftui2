//
//  ContentView.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            mainBody
            palette
        }
        
    }
    
    var mainBody: some View {
        Color.yellow
    }
    
    var palette: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(test.map { (String($0)) }, id: \.self) {
                    e in Text(e)
                }
            }
            
        }
    }
    
    let test = "🥰🥹😆😄😀😜🥹😇😘😉"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
