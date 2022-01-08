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
    
    private let nwo = SocketNode(position: SCNVector3(x: -0.375, y: 0.5, z: -0.375))
    private let neo = SocketNode(position: SCNVector3(x: 0.375, y: 0.5, z: -0.375))
    private let seo = SocketNode(position: SCNVector3(x: 0.375, y: 0.5, z: 0.375))
    private let swo = SocketNode(position: SCNVector3(x: -0.375, y: 0.5, z: 0.375))
    
    private let nwi = SocketNode(position: SCNVector3(x: -0.125, y: 0.5, z: -0.125))
    private let nei = SocketNode(position: SCNVector3(x: 0.125, y: 0.5, z: -0.125))
    private let sei = SocketNode(position: SCNVector3(x: 0.125, y: 0.5, z: 0.125))
    private let swi = SocketNode(position: SCNVector3(x: -0.125, y: 0.5, z: 0.125))
    
    override init() {
        
        super.init()
        
        addChildNode(nwo)
        addChildNode(neo)
        addChildNode(seo)
        addChildNode(swo)
        addChildNode(nwi)
        addChildNode(nei)
        addChildNode(sei)
        addChildNode(swi)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(sockets: OrdinalPattern<SurfaceSocket>) {
        
        nwo.occupied = sockets.value(for: .northWest).outer
        neo.occupied = sockets.value(for: .northEast).outer
        seo.occupied = sockets.value(for: .southEast).outer
        swo.occupied = sockets.value(for: .southWest).outer
        
        nwi.occupied = sockets.value(for: .northWest).inner
        nei.occupied = sockets.value(for: .northEast).inner
        sei.occupied = sockets.value(for: .southEast).inner
        swi.occupied = sockets.value(for: .southWest).inner
    }
}
