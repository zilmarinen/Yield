//
//  Sockets.swift
//
//  Created by Zack Brown on 21/10/2021.
//

import Meadow

struct Sockets: Codable {
    
    var upper = SocketPattern<SurfaceMaterial>(value: .air)
    var lower = SocketPattern<SurfaceMaterial>(value: .air)
    
    var count: Int { upper.count + lower.count }
    
    var isEmpty: Bool { upper.isEmpty && lower.isEmpty }
    var isFull: Bool { upper.isFull && lower.isFull }
}

extension Sockets {
    
    func union(sockets: Sockets) -> Sockets { Sockets(upper: upper.union(pattern: sockets.upper), lower: lower.union(pattern: sockets.lower)) }
    
    func rotate(ordinal: Ordinal) -> Self { Self(upper: upper.rotate(ordinal: ordinal), lower: lower.rotate(ordinal: ordinal)) }
}
