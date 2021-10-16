//
//  EditorView.swift
//
//  Created by Zack Brown on 15/10/2021.
//

import SceneKit
import SwiftUI

struct EditorView: View {

    var body: some View {
        
        SceneView(scene: nil, pointOfView: nil, delegate: nil)
            .toolbar {
                
                Button {  } label: {
                    
                    Image(systemName: "square.and.arrow.up")
                        .help("Export Tileset")
                }
            }
    }
}
