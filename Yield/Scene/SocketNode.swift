//
//  SocketNode.swift
//
//  Created by Zack Brown on 30/10/2021.
//

import Euclid
import Meadow
import SceneKit

class SocketNode: WireframeNode {
    
    enum Constants {
        
        static let socketSize = Distance(x: 0.1, y: 0.1, z: 0.1)
    }
    
    lazy var socket: SCNNode = { SCNNode(geometry: SCNBox(width: Constants.socketSize.x, height: Constants.socketSize.y, length: Constants.socketSize.z, chamferRadius: 0)) }()
    
    var material: SurfaceMaterial = .air {
        
        didSet {
            
            guard material != .air else {
                
                isHidden = true
                
                return
            }
            
            isHidden = false
            
            socket.geometry?.firstMaterial?.diffuse.contents = material.colors.primary.osColor
        }
    }
    
    init(position: SCNVector3) {
        
        super.init(position: position, size: Constants.socketSize)
        
        addChildNode(socket)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
