//
//  AppView.swift
//
//  Created by Zack Brown on 15/10/2021.
//

import SwiftUI

struct AppView: View {
    
    @Binding var document: Document

    var body: some View {
        
        HStack {
            
            ToolView(prototype: $document.model.editorModel.prototype)
            
            EditorView(model: document.model)
                .frame(minWidth: YieldApp.Constants.editorWidth,
                       idealWidth: YieldApp.Constants.editorWidth,
                       minHeight: YieldApp.Constants.editorWidth,
                       idealHeight: YieldApp.Constants.editorWidth)
        }
    }
}
