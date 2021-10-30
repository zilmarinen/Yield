//
//  SocketNode.swift
//
//  Created by Zack Brown on 30/10/2021.
//

import Euclid
import Meadow
import SceneKit

class SocketNode: WireframeNode {
    
    lazy var socket: SCNNode = { SCNNode(geometry: SCNBox(width: Prototype.Constants.socketSize.x, height: Prototype.Constants.socketSize.y, length: Prototype.Constants.socketSize.z, chamferRadius: 0)) }()
    
    var material: SurfaceMaterial = .air {
        
        didSet {
            
            socket.geometry?.firstMaterial?.diffuse.contents = material == .air ? Color.clear.osColor : material.colors.primary.osColor
        }
    }
    
    init(position: SCNVector3) {
        
        super.init(position: position, size: Prototype.Constants.socketSize)
        
        addChildNode(socket)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
