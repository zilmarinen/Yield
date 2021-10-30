//
//  Sockets.swift
//
//  Created by Zack Brown on 21/10/2021.
//

import Meadow

struct Sockets {
    
    var upper = SocketPattern<SurfaceMaterial>(value: .air)
    var lower = SocketPattern<SurfaceMaterial>(value: .air)
    
    var count: Int { upper.count + lower.count }
}

extension Sockets {
    
    func union(sockets: Sockets) -> Sockets { Sockets(upper: upper.union(pattern: sockets.upper), lower: lower.union(pattern: sockets.lower)) }
}
