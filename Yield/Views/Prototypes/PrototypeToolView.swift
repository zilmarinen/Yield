//
//  PrototypeToolView.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Meadow
import SwiftUI

struct PrototypeToolView: View {
    
    let title: String
    
    @Binding private(set) var prototype: EditorTile

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
                
                ToolPropertyView(title: "Format", color: .pink) {

                    Picker("Format", selection: $prototype.format) {

                        ForEach(EditorTile.Format.allCases, id: \.self) { format in

                            Text(format.id.capitalized).tag(format)
                        }
                    }
                }
                
                ToolPropertyView(title: "Cardinal", color: .pink) {

                    Picker("Cardinal", selection: $prototype.cardinal) {

                        ForEach(Cardinal.allCases, id: \.self) { cardinal in

                            Text(cardinal.id.capitalized).tag(cardinal)
                        }
                    }
                }
                
                ToolPropertyView(title: "Ordinal", color: .pink) {

                    Picker("Ordinal", selection: $prototype.ordinal) {

                        ForEach(Ordinal.allCases, id: \.self) { ordinal in

                            Text(ordinal.id.capitalized).tag(ordinal)
                        }
                    }
                }
            }
        }
    }
}
