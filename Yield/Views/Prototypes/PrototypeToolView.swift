//
//  PrototypeToolView.swift
//
//  Created by Zack Brown on 28/10/2021.
//

import SwiftUI

struct PrototypeToolView: View {
    
    let title: String
    
    @ObservedObject private(set) var model: AppViewModel
    
    let hasStyle: Bool
    let hasVolume: Bool

    var body: some View {
        
        ToolPropertySection {

            ToolPropertyGroup(model: .init(title: title)) {
                
                ToolPropertyView(title: "Material", color: .pink) {

                    Picker("Material", selection: $model.editorModel.tileset.material) {

                        ForEach(SurfaceMaterial.allCases, id: \.self) { material in

                            Text(material.id.capitalized).tag(material)
                        }
                    }
                }
                
                if hasStyle {

                    ToolPropertyView(title: "Style", color: .pink) {

                        Picker("Style", selection: $model.editorModel.tileset.style) {

                            ForEach(BiscuitStyle.allCases, id: \.self) { style in

                                Text(style.id.capitalized).tag(style)
                            }
                        }
                    }
                }
                
                if hasVolume {
                
                    ToolPropertyView(title: "Volume", color: .pink) {

                        Picker("Volume", selection: $model.editorModel.tileset.volume) {

                            ForEach(Volume.allCases, id: \.self) { volume in

                                Text(volume.id.capitalized).tag(volume)
                            }
                        }
                    }
                }
            }
        }
    }
}
