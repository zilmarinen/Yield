//
//  Sockets.swift
//
//  Created by Zack Brown on 21/10/2021.
//

struct Sockets {
    
    var upper = SocketPattern<SurfaceMaterial>(value: .air)
    var lower = SocketPattern<SurfaceMaterial>(value: .air)
    
    var count: Int { upper.count + lower.count }
}
