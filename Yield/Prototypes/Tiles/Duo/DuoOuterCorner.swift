//
//  DuoOuterCorner.swift
//
//  Created by Zack Brown on 06/11/2021.
//

import Euclid
import Meadow

struct DuoOuterCorner: PrototypeTile {
    
    let primary: SocketConfig
    let secondary: SocketConfig
    
    var rotations: [Ordinal] { Ordinal.allCases }
    
    var sockets: Sockets {
        
        var sockets = Sockets()
        
        return sockets
    }
    
    var mesh: Mesh {
        
        return Mesh([])
    }
}

