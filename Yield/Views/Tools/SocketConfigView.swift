//
//  SocketConfigView.swift
//
//  Created by Zack Brown on 03/11/2021.
//

import Meadow
import SwiftUI

struct SocketConfigView: View {
    
    let title: String
    
    @Binding private(set) var config: SocketConfig
    
    let hasFormat: Bool
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
                
                if hasFormat {
                 
                    ToolPropertyView(title: "Format", color: .pink) {

                        Picker("Format", selection: $config.format) {

                            ForEach(SocketConfig.Format.allCases, id: \.self) { format in

                                Text(format.id.capitalized).tag(format)
                            }
                        }
                    }
                    
                    if config.format == .edge {
                        
                        ToolPropertyView(title: "Cardinal", color: .pink) {

                            Picker("Cardinal", selection: $config.cardinal) {

                                ForEach(Cardinal.allCases, id: \.self) { cardinal in

                                    Text(cardinal.id.capitalized).tag(cardinal)
                                }
                            }
                        }
                    }
                    
                    if config.format == .corner {
                    
                        ToolPropertyView(title: "Ordinal", color: .pink) {

                            Picker("Ordinal", selection: $config.ordinal) {

                                ForEach(Ordinal.allCases, id: \.self) { ordinal in

                                    Text(ordinal.id.capitalized).tag(ordinal)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
