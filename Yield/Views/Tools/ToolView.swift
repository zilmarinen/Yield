//
//  ToolView.swift
//
//  Created by Zack Brown on 15/10/2021.
//

import SwiftUI

struct ToolView: View {
    
    @Binding private(set) var prototype: EditorTile

    var body: some View {
        
        ScrollView {

            VStack {
                    
                PrototypeToolView(title: prototype.tile.id.capitalized, prototype: $prototype)
                
                switch prototype.type {
                    
                case .mono:
                    
                    SocketConfigView(title: "Mono", config: $prototype.primary, hasStyle: prototype.tile != .plateau, hasVolume: true)
                    
                case .duo:
                    
                    SocketConfigView(title: "Mono", config: $prototype.primary, hasStyle: prototype.tile != .plateau, hasVolume: true)
                    SocketConfigView(title: "Duo", config: $prototype.secondary, hasStyle: false, hasVolume: true)
                    
                case .tri: EmptyView()
                case .tetra: EmptyView()
                }
                
                SocketsView(prototype: prototype)

                Spacer()
            }
            .padding()
        }
        .frame(minWidth: YieldApp.Constants.toolWidth, idealWidth: YieldApp.Constants.toolWidth, maxWidth: YieldApp.Constants.toolWidth)
    }
}
