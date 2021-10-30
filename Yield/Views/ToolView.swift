//
//  ToolView.swift
//
//  Created by Zack Brown on 15/10/2021.
//

import SwiftUI

struct ToolView: View {
    
    @ObservedObject private(set) var model: AppViewModel
    
    @ObservedObject private(set) var tileset: Tileset

    var body: some View {
        
        ScrollView {

            VStack {
                
                ToolPropertySection {

                    ToolPropertyGroup(model: .init(title: "Tileset", imageName: "square.grid.3x3")) {

                        ToolPropertyView(title: "Name", color: .pink) {

                            TextField("Name", text: $tileset.identifier)
                        }

                        ToolPropertyView(title: "Shape", color: .pink) {

                            Picker("Shape", selection: $model.editorModel.tileset.tile) {

                                ForEach(Tile.allCases, id: \.self) { tile in

                                    Text(tile.id.capitalized).tag(tile)
                                }
                            }
                        }
                    }
                }
                
                switch tileset.tile {
                    
                case .edge: PrototypeToolView(title: "Edge", model: model, hasStyle: true, hasVolume: true)
                case .groove: PrototypeToolView(title: "Groove", model: model, hasStyle: true, hasVolume: true)
                case .innerCorner: PrototypeToolView(title: "Inner Corner", model: model, hasStyle: true, hasVolume: true)
                case .outerCorner: PrototypeToolView(title: "Outer Corner", model: model, hasStyle: true, hasVolume: true)
                case .plateau: PrototypeToolView(title: "Plateau", model: model, hasStyle: false, hasVolume: true)
                }
                
                SocketsView(tileset: tileset)

                Spacer()
            }
            .padding()
        }
        .frame(minWidth: YieldApp.Constants.toolWidth, idealWidth: YieldApp.Constants.toolWidth, maxWidth: YieldApp.Constants.toolWidth)
    }
}
