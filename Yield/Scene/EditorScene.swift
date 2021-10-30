//
//  EditorScene.swift
//
//  Created by Zack Brown on 25/10/2021.
//

import Euclid
import Meadow
import SceneKit

class EditorScene: SCNScene {
    
    lazy var cameraJig: SCNNode = {
        
        let node = SCNNode()
        
        node.camera = SCNCamera()
        node.position = SCNVector3(x: 5, y: 5, z: 5)
        node.look(at: SCNVector3(x: 0, y: 0, z: 0))
        
        return node
    }()
    
    lazy var wireframe: SCNNode = {
        
        let node = WireframeNode(position: SCNVector3(x: 0, y: 0.5, z: 0), size: .one)
        
        node.addChildNode(WireframeNode(position: SCNVector3(x: 0.25, y: 0, z: 0), size: Vector(x: 0.5, y: 1, z: 1)))
        node.addChildNode(WireframeNode(position: SCNVector3(x: 0, y: 0, z: 0.25), size: Vector(x: 1, y: 1, z: 0.5)))
        node.addChildNode(WireframeNode(position: SCNVector3(x: 0, y: 0.25, z: 0), size: Vector(x: 1, y: 0.5, z: 1)))
        
        return node
    }()
    
    let sockets = SocketNode()
    
    let model = SCNNode()
    
    override init() {
        
        super.init()
        
        rootNode.addChildNode(cameraJig)
        rootNode.addChildNode(wireframe)
        rootNode.addChildNode(sockets)
        rootNode.addChildNode(model)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
