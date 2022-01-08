//
//  ToolView.swift
//
//  Created by Zack Brown on 15/10/2021.
//

import SwiftUI

struct ToolView: View {
    
    @ObservedObject var model: EditorViewModel

    var body: some View {
        
        ScrollView {

            VStack {
                    
                PrototypeToolView(title: model.prototype.tile.id.capitalized, prototype: $model.prototype)
                
                SocketsView(prototype: model.prototype)

                Spacer()
            }
            .padding()
        }
        .frame(minWidth: YieldApp.Constants.toolWidth, idealWidth: YieldApp.Constants.toolWidth, maxWidth: YieldApp.Constants.toolWidth)
    }
}
