//
//  SocketSet.swift
//
//  Created by Zack Brown on 30/10/2021.
//

import Euclid
import Meadow
import SceneKit

class SocketSet: SCNNode {
    
    private let lc0 = SocketNode(position: SCNVector3(x: -0.5, y: 0, z: -0.5))
    private let lc1 = SocketNode(position: SCNVector3(x: 0.5, y: 0, z: -0.5))
    private let lc2 = SocketNode(position: SCNVector3(x: 0.5, y: 0, z: 0.5))
    private let lc3 = SocketNode(position: SCNVector3(x: -0.5, y: 0, z: 0.5))
    
    private let uc0 = SocketNode(position: SCNVector3(x: -0.5, y: Prototype.Constants.ceiling, z: -0.5))
    private let uc1 = SocketNode(position: SCNVector3(x: 0.5, y: Prototype.Constants.ceiling, z: -0.5))
    private let uc2 = SocketNode(position: SCNVector3(x: 0.5, y: Prototype.Constants.ceiling, z: 0.5))
    private let uc3 = SocketNode(position: SCNVector3(x: -0.5, y: Prototype.Constants.ceiling, z: 0.5))
    
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
        
        lc0.material = sockets.lower.value(for: .northWest)
        lc1.material = sockets.lower.value(for: .northEast)
        lc2.material = sockets.lower.value(for: .southEast)
        lc3.material = sockets.lower.value(for: .southWest)
        
        uc0.material = sockets.upper.value(for: .northWest)
        uc1.material = sockets.upper.value(for: .northEast)
        uc2.material = sockets.upper.value(for: .southEast)
        uc3.material = sockets.upper.value(for: .southWest)
    }
}