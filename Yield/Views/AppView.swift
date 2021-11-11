//
//  AppView.swift
//
//  Created by Zack Brown on 15/10/2021.
//

import SwiftUI

struct AppView: View {
    
    let model: AppViewModel

    var body: some View {
        
        HStack {
            
            ToolView(model: model.editorModel)
            
            EditorView(model: model)
                .frame(minWidth: YieldApp.Constants.editorWidth,
                       idealWidth: YieldApp.Constants.editorWidth,
                       minHeight: YieldApp.Constants.editorWidth,
                       idealHeight: YieldApp.Constants.editorWidth)
        }
    }
}
