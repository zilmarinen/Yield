//
//  Document.swift
//
//  Created by Zack Brown on 15/10/2021.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    
    static var model: UTType { UTType(importedAs: "com.so.yield.model") }
}

class Document: FileDocument, ObservableObject {
    
    static var readableContentTypes: [UTType] { [.model] }
        
    @Published var model: AppViewModel

    init(model: AppViewModel) {
        
        self.model = model
    }

    required init(configuration: ReadConfiguration) throws {
        
        model = try AppViewModel(fileWrapper: configuration.file)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        
        return try model.fileWrapper()
    }
}
