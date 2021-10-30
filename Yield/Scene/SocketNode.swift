//
//  SocketNode.swift
//
//  Created by Zack Brown on 30/10/2021.
//

import Euclid
import Meadow
import SceneKit

class SocketNode: SCNNode {
    
    private let lc0 = WireframeNode(position: SCNVector3(x: -0.5, y: 0, z: -0.5), size: Prototype.Constants.socketSize)
    private let lc1 = WireframeNode(position: SCNVector3(x: 0.5, y: 0, z: -0.5), size: Prototype.Constants.socketSize)
    private let lc2 = WireframeNode(position: SCNVector3(x: 0.5, y: 0, z: 0.5), size: Prototype.Constants.socketSize)
    private let lc3 = WireframeNode(position: SCNVector3(x: -0.5, y: 0, z: -0.5), size: Prototype.Constants.socketSize)
    
    private let uc0 = WireframeNode(position: SCNVector3(x: -0.5, y: Prototype.Constants.ceiling, z: -0.5), size: Prototype.Constants.socketSize)
    private let uc1 = WireframeNode(position: SCNVector3(x: 0.5, y: Prototype.Constants.ceiling, z: -0.5), size: Prototype.Constants.socketSize)
    private let uc2 = WireframeNode(position: SCNVector3(x: 0.5, y: Prototype.Constants.ceiling, z: 0.5), size: Prototype.Constants.socketSize)
    private let uc3 = WireframeNode(position: SCNVector3(x: -0.5, y: Prototype.Constants.ceiling, z: -0.5), size: Prototype.Constants.socketSize)
    
    override init() {
        
        super.init()
        
        addChildNode(lc0)
        addChildNode(lc1)
        addChildNode(lc2)
        addChildNode(lc3)
        addChildNode(uc0)
        addChildNode(uc1)
        addChildNode(uc2)
        addChildNode(uc3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(sockets: Sockets) {
        
        
    }
}
