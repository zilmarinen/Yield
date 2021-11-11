//
//  PrototypeToolView.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Meadow
import SwiftUI

struct PrototypeToolView: View {
    
    let title: String
    
    @Binding var prototype: EditorTile

    var body: some View {
        
        ToolPropertySection {

            ToolPropertyGroup(model: .init(title: "Tileset", imageName: "square.grid.3x3")) {
                
                ToolPropertyView(title: "Shape", color: .pink) {

                    Picker("Shape", selection: $prototype.tile) {

                        ForEach(Tile.allCases, id: \.self) { tile in

                            Text(tile.id.capitalized).tag(tile)
                        }
                    }
                }
                
                ToolPropertyView(title: "Type", color: .pink) {

                    Picker("Type", selection: $prototype.type) {

                        ForEach(TileType.allCases, id: \.self) { type in

                            Text(type.id.capitalized).tag(type)
                        }
                    }
                }
            }
        }
    }
}
