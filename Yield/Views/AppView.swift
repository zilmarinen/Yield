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
            
            ToolView(model: document.model, tileset: document.model.editorModel.tileset)
            
            EditorView(model: document.model)
                .frame(idealWidth: YieldApp.Constants.editorWidth, idealHeight: YieldApp.Constants.editorWidth)
        }
    }
}
