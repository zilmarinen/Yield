//
//  ToolView.swift
//
//  Created by Zack Brown on 15/10/2021.
//

import SwiftUI

struct ToolView: View {
    
    @ObservedObject var tileset: Tileset

    var body: some View {
        
        ScrollView {

            VStack {

                ToolPropertySection {

                    ToolPropertyGroup(model: .init(title: "Tileset", imageName: "square.grid.3x3", badge: .init(title: "0", color: .pink))) {

                        ToolPropertyView(title: "Name", color: .pink) {

                            TextField("Name", text: $tileset.name)
                        }

                        ToolPropertyView(title: "Tile", color: .pink) {

                            HStack {

                                BadgeView(model: .init(title: "\(tileset.tile)", color: .pink))

                                Stepper("Elevation", value: $tileset.tile, in: 0...15)
                            }
                        }
                    }
                }

                ToolPropertySection {

                    ToolPropertyGroup(model: .init(title: "Properties", badge: .init(title: "0", color: .pink))) {

                        ToolPropertyView(title: "Style", color: .pink) {

                            Picker("Style", selection: $tileset.style) {

                                ForEach(Tileset.Style.allCases, id: \.self) { style in

                                    Text(style.id.capitalized).tag(style)
                                }
                            }
                        }

                        ToolPropertyView(title: "Inset", color: .pink) {

//                            Picker("Inset", selection: $tileset.inset) {
//
//                                ForEach(Tileset.Inset.allCases, id: \.self) { inset in
//
//                                    Text(inset.id.capitalized).tag(inset)
//                                }
//                            }
                        }
                    }
                }

                Spacer()
            }
            .padding()
        }
        .frame(minWidth: YieldApp.Constants.toolWidth, idealWidth: YieldApp.Constants.toolWidth, maxWidth: YieldApp.Constants.toolWidth)
    }
}
