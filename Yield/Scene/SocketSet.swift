//
//  SocketSet.swift
//
//  Created by Zack Brown on 30/10/2021.
//

import Euclid
import Harvest
import Meadow
import SceneKit

class SocketSet: SCNNode {
    
    private let lc0 = SocketNode(position: SCNVector3(x: -0.5, y: 0, z: -0.5))
    private let lc1 = SocketNode(position: SCNVector3(x: 0.5, y: 0, z: -0.5))
    private let lc2 = SocketNode(position: SCNVector3(x: 0.5, y: 0, z: 0.5))
    private let lc3 = SocketNode(position: SCNVector3(x: -0.5, y: 0, z: 0.5))
    
    private let uc0 = SocketNode(position: SCNVector3(x: -0.5, y: 0.5, z: -0.5))
    private let uc1 = SocketNode(position: SCNVector3(x: 0.5, y: 0.5, z: -0.5))
    private let uc2 = SocketNode(position: SCNVector3(x: 0.5, y: 0.5, z: 0.5))
    private let uc3 = SocketNode(position: SCNVector3(x: -0.5, y: 0.5, z: 0.5))
    
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
    
    func setup(sockets: SurfaceSockets) {
        
        lc0.material = sockets.material(for: .northWest)
        lc1.material = sockets.material(for: .northEast)
        lc2.material = sockets.material(for: .southEast)
        lc3.material = sockets.material(for: .southWest)
        
        uc0.material = sockets.material(for: .northWest)
        uc1.material = sockets.material(for: .northEast)
        uc2.material = sockets.material(for: .southEast)
        uc3.material = sockets.material(for: .southWest)
    }
}
