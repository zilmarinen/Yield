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
    
    @Published var prototype = EditorTile() {
        
        didSet {

            scene.model.geometry = SCNGeometry(prototype.mesh)
            scene.sockets.setup(sockets: prototype.sockets)
        }
    }
    
    @Published var showWireframes: Bool = true {
        
        didSet {
            
            scene.wireframe.isHidden = !showWireframes
        }
    }
    
    @Published var showSockets: Bool = true {
        
        didSet {
            
            scene.sockets.isHidden = !showSockets
        }
    }
}
