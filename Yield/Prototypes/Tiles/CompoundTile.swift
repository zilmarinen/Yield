//
//  CompoundTile.swift
//
//  Created by Zack Brown on 30/10/2021.
//

import Euclid
import Meadow

struct CompoundTile: PrototypeTile {
    
    let tiles: [PrototypeTile]
    
    var sockets: Sockets {
        
        var result = Sockets()
        
        for tile in tiles {
            
            result = result.union(sockets: tile.sockets)
        }
        
        return result
    }
    
    var polygons: [Euclid.Polygon] {
        
        var result = Mesh([])
        
        for tile in tiles {
            
            let mesh = Mesh(tile.polygons)
            
            result = result.union(mesh)
        }
        
        return result.polygons
    }
}
