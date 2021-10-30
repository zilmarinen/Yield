//
//  EditorView.swift
//
//  Created by Zack Brown on 15/10/2021.
//

import SceneKit
import SwiftUI

struct EditorView: View {
    
    @ObservedObject var model: AppViewModel

    var body: some View {
        
        SceneView(scene: model.editorModel.scene,
                  pointOfView: model.editorModel.scene.cameraJig,
                  options: [.allowsCameraControl,
                                .autoenablesDefaultLighting],
                  delegate: nil)
            .toolbar {
                
                Menu {
                    
                    Toggle("Show wireframes", isOn: $model.editorModel.showWireframes)
                    
                } label: {
                    
                    Label("Change view settings", systemImage: "slider.horizontal.3")
                }
                
                Divider()
                
                Button { model.export() } label: {
                    
                    Image(systemName: "square.and.arrow.up")
                        .help("Export Tileset")
                }
            }
    }
}
