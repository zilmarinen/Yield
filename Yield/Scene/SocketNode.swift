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
        
        static let socketSize = Vector(x: 0.05, y: 0.05, z: 0.05)
    }
    
    lazy var socket: SCNNode = { SCNNode(geometry: SCNBox(width: Constants.socketSize.x, height: Constants.socketSize.y, length: Constants.socketSize.z, chamferRadius: 0)) }()
    
    var occupied: Bool = false {
        
        didSet {
            
            isHidden = !occupied
            
            socket.geometry?.firstMaterial?.diffuse.contents = occupied ? Color.green : Color.clear
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
