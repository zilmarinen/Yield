//
//  WireframeNode.swift
//
//  Created by Zack Brown on 30/10/2021.
//

import Euclid
import Meadow
import SceneKit

class WireframeNode: SCNNode {
    
    init(position: SCNVector3, size: Distance) {
        
        super.init()
        
        self.position = position
        self.geometry = SCNGeometry(wireframe: Mesh.cube(center: .origin, size: size, faces: .default, material: MDWColor.black))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
