//
//  ViewModel.swift
//  EmojiArt
//
//  Created by 顾艳华 on 2022/11/21.
//

import SwiftUI
import UniformTypeIdentifiers

class ViewModel: ReferenceFileDocument {
    
    
    static var readableContentTypes = [UTType.art]
    static var writeableContentTypes = [UTType.art]
    
    
    func snapshot(contentType: UTType) throws -> Data {
        try model.json()
    }
    
    func fileWrapper(snapshot: Data, configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: snapshot)
    }
    
    required init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
           model = try JSONDecoder().decode(Model.self, from: data)
           fetch()
       } else {
           throw CocoaError(.fileReadCorruptFile)
       }
    }
    
    @Published var model: Model {
        didSet {
//            autesave()
            if model.background != oldValue.background {
                fetch()
            }
        }
    }
    @Published var backgroundImage: UIImage?
    
    init() {
//        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        url = url?.appendingPathComponent("autosave.emoji")
//        if let url = url, let model = try? Model(from: url) {
//            self.model = model
//            fetch()
//        } else {
        self.model = Model()
//        }
    
//        model.add("🥰", at: (100,200), 50)
//        model.add("🥹", at: (-100,-200), 100)
    }
    
//    func autesave() {
//        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        url = url?.appendingPathComponent("autosave.emoji")
//        if let url = url {
//            do {
//                let json = try model.json()
//                try json.write(to: url)
//
//                print("save \(String(data: json, encoding: .utf8) ?? "nil")")
//            }catch{
//
//            }
//        }
//    }
    
    func fetch() {
        switch model.background {
        case .url(let url):
            DispatchQueue.global(qos: .userInitiated).async {
                let image = try? Data(contentsOf: url)
                DispatchQueue.main.async { [weak self] in
                    if image != nil {
                        self?.backgroundImage = UIImage(data: image!)
                    }
                }
            }
        default: break
        }
    }
    
//    func move(_ e: Model.Emoji,to offset: CGSize) {
//        if let i = model.emojis.index(matching: e) {
//            model.emojis[i].x += Int(offset.width)
//            model.emojis[i].y += Int(offset.height)
//        }
//    }
//    
//    func scale(_ e: Model.Emoji, by scale: CGFloat, undoManager: UndoManager?) {
//        if let i = model.emojis.index(matching: e) {
//            model.emojis[i].size = Int((CGFloat(model.emojis[i].size) * scale).rounded(.toNearestOrAwayFromZero))
//        }
//    }
//    
    func undoablyPerform(operation: String, with undoManager: UndoManager? = nil, doit: () -> Void) {
        let oldModel = model
        doit()
        undoManager?.registerUndo(withTarget: self) { myself in
            myself.undoablyPerform(operation: operation, with: undoManager) {
                myself.model = oldModel
            }
        }
        undoManager?.setActionName(operation)
    }
}
