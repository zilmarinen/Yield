//
//  PrototypeToolView.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import Harvest
import Meadow
import SwiftUI

struct PrototypeToolView: View {
    
    let title: String
    
    @Binding var prototype: EditorTile

    var body: some View {
        
        ToolPropertySection {

            ToolPropertyGroup(model: .init(title: "Tileset", imageName: "square.grid.3x3")) {
                
                ToolPropertyView(title: "Tile", color: .pink) {

                    Picker("Tile", selection: $prototype.tile) {

                        ForEach(Tile.allCases, id: \.self) { tile in

                            Text(tile.id.capitalized).tag(tile)
                        }
                    }
                }
                
                ToolPropertyView(title: "Shape", color: .pink) {

                    Picker("Shape", selection: $prototype.shape) {

                        ForEach(prototype.tile.shapes, id: \.self) { shape in

                            Text(shape.id.capitalized).tag(shape)
                        }
                    }
                }
                
                ToolPropertyView(title: "Material", color: .pink) {

                    Picker("Material", selection: $prototype.material) {

                        ForEach(SurfaceMaterial.allCases, id: \.self) { material in

                            Text(material.id.capitalized).tag(material)
                        }
                    }
                }
                
                ToolPropertyView(title: "Volume", color: .pink) {

                    Picker("Volume", selection: $prototype.volume) {

                        ForEach(BiscuitVolume.solids, id: \.self) { volume in

                            Text(volume.id.capitalized).tag(volume)
                        }
                    }
                }
            }
        }
    }
}
