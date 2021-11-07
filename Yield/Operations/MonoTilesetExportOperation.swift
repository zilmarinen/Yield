//
//  MonoTilesetExportOperation.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Foundation
import PeakOperation

class MonoTilesetExportOperation: ConcurrentOperation, ProducesResult {
    
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    override func execute() {
        
        var tiles: [PrototypeTile] = []
        
        for material in SurfaceMaterial.solids {
            
            tiles.append(contentsOf: edges(with: material))
            tiles.append(contentsOf: grooves(with: material))
            tiles.append(contentsOf: innerCorners(with: material))
            tiles.append(contentsOf: outerCorners(with: material))
            tiles.append(contentsOf: plateau(with: material))
        }
        
        let exportOperation = PrototypeTileExportOperation(type: .mono, prototypes: tiles, startIndex: 0)
        
        let group = DispatchGroup()
        
        group.enter()
        
        exportOperation.enqueue(on: internalQueue) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .failure(let error): self.output = .failure(error)
            case .success(let output):
                
                let (tileset, wrappers) = output
                
                self.output = .success((tileset, wrappers))
            }
            
            group.leave()
        }
        
        group.wait()
        
        finish()
    }
}

extension MonoTilesetExportOperation {
    
    func edges(with material: SurfaceMaterial) -> [PrototypeTile] { [MonoEdge(config: .init(material: material, style: .concave, volume: .crown, type: .edge(.north))),
                                                                     MonoEdge(config: .init(material: material, style: .convex, volume: .crown, type: .edge(.north))),
                                                                     MonoEdge(config: .init(material: material, style: .straight, volume: .crown, type: .edge(.north))),
                                                                     
                                                                     MonoEdge(config: .init(material: material, style: .concave, volume: .mantle, type: .edge(.north))),
                                                                     MonoEdge(config: .init(material: material, style: .convex, volume: .mantle, type: .edge(.north))),
                                                                     MonoEdge(config: .init(material: material, style: .straight, volume: .mantle, type: .edge(.north))),
                                                                     
                                                                     DuoEdge(primary: .init(material: material, style: .concave, volume: .crown, type: .edge(.north)),
                                                                             secondary: .init(material: material, style: .concave, volume: .mantle, type: .edge(.south))),
                                                                     DuoEdge(primary: .init(material: material, style: .convex, volume: .crown, type: .edge(.north)),
                                                                             secondary: .init(material: material, style: .convex, volume: .mantle, type: .edge(.south))),
                                                                     DuoEdge(primary: .init(material: material, style: .straight, volume: .crown, type: .edge(.north)),
                                                                             secondary: .init(material: material, style: .straight, volume: .mantle, type: .edge(.south)))]
    }
    
    func grooves(with material: SurfaceMaterial) -> [PrototypeTile] { [MonoGroove(config: .init(material: material, style: .concave, volume: .crown, type: .corner(.northWest))),
                                                                       MonoGroove(config: .init(material: material, style: .convex, volume: .crown, type: .corner(.northWest))),
    
                                                                       MonoGroove(config: .init(material: material, style: .concave, volume: .mantle, type: .corner(.northWest))),
                                                                       MonoGroove(config: .init(material: material, style: .convex, volume: .mantle, type: .corner(.northWest)))] }
    
    func innerCorners(with material: SurfaceMaterial) -> [PrototypeTile] { [MonoInnerCorner(config: .init(material: material, style: .concave, volume: .crown, type: .corner(.southWest))),
                                                                            MonoInnerCorner(config: .init(material: material, style: .convex, volume: .crown, type: .corner(.southWest))),
    
                                                                            MonoInnerCorner(config: .init(material: material, style: .concave, volume: .mantle, type: .corner(.southWest))),
                                                                            MonoInnerCorner(config: .init(material: material, style: .convex, volume: .mantle, type: .corner(.southWest)))] }
    
    func outerCorners(with material: SurfaceMaterial) -> [PrototypeTile] { [MonoOuterCorner(config: .init(material: material, style: .concave, volume: .crown, type: .corner(.northWest))),
                                                                            MonoOuterCorner(config: .init(material: material, style: .convex, volume: .crown, type: .corner(.northWest))),
    
                                                                            MonoOuterCorner(config: .init(material: material, style: .concave, volume: .mantle, type: .corner(.northWest))),
                                                                            MonoOuterCorner(config: .init(material: material, style: .convex, volume: .mantle, type: .corner(.northWest)))] }
    
    func plateau(with material: SurfaceMaterial) -> [PrototypeTile] { [MonoPlateau(config: .init(material: material, style: .straight, volume: .crown, type: .plateau)),
                                                                       
                                                                       MonoPlateau(config: .init(material: material, style: .straight, volume: .mantle, type: .plateau))] }
}
