//
//  EditorViewModel.swift
//
//  Created by Zack Brown on 21/10/2021.
//

import Euclid
import SceneKit
import SwiftUI

class EditorViewModel: ObservableObject {
    
    let scene = EditorScene()
    
    @Published var tileset = Tileset() {
        
        didSet {
            
            scene.model.geometry = SCNGeometry(tileset.mesh)
        }
    }
    
    @Published var showWireframes: Bool = true {
        
        didSet {
            
            scene.wireframe.isHidden = !showWireframes
        }
    }
}
