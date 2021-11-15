//
//  SurfaceGrid.swift
//
//  Created by Zack Brown on 04/11/2021.
//

import Euclid
import Foundation
import Meadow

struct SurfaceGrid {
    
    let corners = Ordinal.corners
    
    var center: Position { .origin }
    
    func corner(ordinal: Ordinal) -> Position { corners[ordinal.corner] }
    
    func edge(cardinal: Cardinal) -> Position {
        
        let (o0, o1) = cardinal.ordinals
        
        return corners[o0.corner].lerp(corners[o1.corner], 0.5)
    }
    
    func inner(corner ordinal: Ordinal) -> Position {
        
        let (c0, _) = ordinal.cardinals
        let (_, o1) = ordinal.ordinals
        
        let e0 = edge(cardinal: c0, ordinal: ordinal, inset: .inner)
        let e1 = edge(cardinal: c0.opposite, ordinal: o1, inset: .inner)
        
        return e0.lerp(e1, 0.5 - Prototype.Constants.insetDepth)
    }
    
    func edge(cardinal: Cardinal, ordinal: Ordinal, inset: Inset) -> Position {
        
        switch inset {
        case .inner: return edge(cardinal: cardinal, ordinal: ordinal, interpolator: 0.5 - Prototype.Constants.insetDepth)
        case .outer: return edge(cardinal: cardinal, ordinal: ordinal, interpolator: 0.5 + Prototype.Constants.insetDepth)
        case .none:
            
            let (c0, c1) = ordinal.cardinals
            
            guard c0 != cardinal && c1 != cardinal else { return edge(cardinal: cardinal) }
            
            return center
        }
    }
}

extension SurfaceGrid {
    
    private func edge(cardinal: Cardinal, ordinal: Ordinal, interpolator: Double) -> Position {
        
        let (c0, c1) = ordinal.cardinals
        let (o0, o1) = ordinal.ordinals
        
        guard c0 != cardinal else { return corner(ordinal: ordinal).lerp(corner(ordinal: o0), interpolator) }
        guard c1 != cardinal else { return corner(ordinal: ordinal).lerp(corner(ordinal: o1), interpolator) }
        
        if c0 == cardinal.opposite {
          
            return edge(cardinal: c1).lerp(edge(cardinal: c1.opposite), interpolator)
        }
        
        return edge(cardinal: c0).lerp(edge(cardinal: c0.opposite), interpolator)
    }
}
