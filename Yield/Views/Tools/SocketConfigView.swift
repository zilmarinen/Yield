//
//  SocketConfigView.swift
//
//  Created by Zack Brown on 03/11/2021.
//

import SwiftUI

struct SocketConfigView: View {
    
    let title: String
    
    @Binding private(set) var config: SocketConfig
    
    let hasStyle: Bool
    let hasVolume: Bool

    var body: some View {
        
        ToolPropertySection {
            
            ToolPropertyGroup(model: .init(title: title)) {
                
                ToolPropertyView(title: "Material", color: .pink) {

                    Picker("Material", selection: $config.material) {

                        ForEach(SurfaceMaterial.allCases, id: \.self) { material in

                            Text(material.id.capitalized).tag(material)
                        }
                    }
                }
                
                if hasStyle {

                    ToolPropertyView(title: "Style", color: .pink) {

                        Picker("Style", selection: $config.style) {

                            ForEach(BiscuitStyle.allCases, id: \.self) { style in

                                Text(style.id.capitalized).tag(style)
                            }
                        }
                    }
                }
                
                if hasVolume {
                
                    ToolPropertyView(title: "Volume", color: .pink) {

                        Picker("Volume", selection: $config.volume) {

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
