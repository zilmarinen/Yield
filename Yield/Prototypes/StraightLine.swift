//
//  StraightLine.swift
//
//  Created by Zack Brown on 04/11/2021.
//

import Euclid

struct StraightLine {
    
    public let start: Vector
    public let end: Vector
    
    public let points: [Vector]
    
    init(start: Vector, end: Vector) {
        
        self.start = start
        self.end = end
        self.points = [start, end]
    }
}

extension StraightLine {
    
    func polygon(color: Color) -> Euclid.Polygon? {
     
        let ceiling = Vector(x: 0, y: Prototype.Constants.ceiling, z: 0)
        
        let v0 = end + ceiling
        let v1 = start + ceiling
        
        let face = [v1, v0, end, start]
        let normal = face.normal()
        
        let vertices = face.map{ Vertex($0, normal, nil, color) }
        
        return Polygon(vertices)
    }
}