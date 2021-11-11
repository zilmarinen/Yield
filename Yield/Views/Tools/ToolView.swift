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
                
                switch model.prototype.type {
                    
                case .mono:
                    
                    SocketConfigView(title: "Primary", config: $model.prototype.primary, hasFormat: true, hasStyle: model.prototype.tile != .plateau, hasVolume: true)
                    
                case .duo:
                    
                    SocketConfigView(title: "Primary", config: $model.prototype.primary, hasFormat: true, hasStyle: model.prototype.tile != .plateau, hasVolume: true)
                    SocketConfigView(title: "Seconary", config: $model.prototype.secondary, hasFormat: true, hasStyle: false, hasVolume: true)
                    
                case .tri:
                    
                    SocketConfigView(title: "Primary", config: $model.prototype.primary, hasFormat: true, hasStyle: model.prototype.tile != .plateau, hasVolume: true)
                    SocketConfigView(title: "Seconary", config: $model.prototype.secondary, hasFormat: true, hasStyle: false, hasVolume: true)
                    SocketConfigView(title: "Tertiary", config: $model.prototype.tertiary, hasFormat: true, hasStyle: false, hasVolume: true)
                    
                case .tetra:
                    
                    SocketConfigView(title: "Primary", config: $model.prototype.primary, hasFormat: false, hasStyle: true, hasVolume: true)
                    SocketConfigView(title: "Seconary", config: $model.prototype.secondary, hasFormat: false, hasStyle: false, hasVolume: true)
                    SocketConfigView(title: "Tertiary", config: $model.prototype.tertiary, hasFormat: false, hasStyle: false, hasVolume: true)
                    SocketConfigView(title: "Quaternary", config: $model.prototype.quaternary, hasFormat: false, hasStyle: false, hasVolume: true)
                }
                
                SocketsView(prototype: model.prototype)

                Spacer()
            }
            .padding()
        }
        .frame(minWidth: YieldApp.Constants.toolWidth, idealWidth: YieldApp.Constants.toolWidth, maxWidth: YieldApp.Constants.toolWidth)
    }
}
