//
//  MonoTilesetExportOperation.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Foundation
import Meadow
import PeakOperation

class MonoTilesetExportOperation: ConcurrentOperation, ProducesResult {
    
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    override func execute() {
        
        var prototypes: [PrototypeTile] = []
        
        for material in SurfaceMaterial.solids {
            
            prototypes.append(contentsOf: edges(with: material))
            prototypes.append(contentsOf: grooves(with: material))
            prototypes.append(contentsOf: innerCorners(with: material))
            prototypes.append(contentsOf: outerCorners(with: material))
            prototypes.append(contentsOf: plateau(with: material))
        }
        
        let exportOperation = PrototypeTileExportOperation(type: .mono, prototypes: prototypes, tileCache: Tileset(), fileCache: [:])
        
        let group = DispatchGroup()
        
        group.enter()
        
        exportOperation.enqueue(on: internalQueue) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .failure(let error): self.output = .failure(error)
            case .success(let output): self.output = .success(output)
            }
            
            group.leave()
        }
        
        group.wait()
        
        finish()
    }
}

extension MonoTilesetExportOperation {
    
    private func edges(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        return [Volume.crown, .mantle].flatMap {
            
            edges(with: .init(material: material, style: .straight, volume: $0, type: .edge(.north)))
        }
    }
    
    private func grooves(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        return [Volume.crown, .mantle].flatMap {
            
            grooves(with: .init(material: material, style: .straight, volume: $0, type: .corner(.northWest)))
        }
    }
    
    private func innerCorners(with material: SurfaceMaterial) -> [PrototypeTile] {
    
        return [Volume.crown, .mantle].flatMap {
            
            innerCorners(with: .init(material: material, style: .straight, volume: $0, type: .corner(.southWest)))
        }
    }
    
    private func outerCorners(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        return [Volume.crown, .mantle].flatMap {
            
            outerCorners(with: .init(material: material, style: .straight, volume: $0, type: .corner(.northWest)))
        }
    }
    
    private func plateau(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        return [Volume.crown, .mantle].flatMap {
            
            plateau(with: .init(material: material, style: .straight, volume: $0, type: .plateau))
        }
    }
}

extension MonoTilesetExportOperation {
    
    private func edges(with primary: SocketConfig) -> [PrototypeTile] { [MonoEdge(config: primary.with(style: .concave)),
                                                                         MonoEdge(config: primary.with(style: .convex)),
                                                                         MonoEdge(config: primary.with(style: .straight))] }
    
    private func grooves(with primary: SocketConfig) -> [PrototypeTile] { [MonoGroove(config: primary.with(style: .concave)),
                                                                           MonoGroove(config: primary.with(style: .convex))] }
    
    private func innerCorners(with primary: SocketConfig) -> [PrototypeTile] { [MonoInnerCorner(config: primary.with(style: .concave)),
                                                                                MonoInnerCorner(config: primary.with(style: .convex))] }
    
    private func outerCorners(with primary: SocketConfig) -> [PrototypeTile] { [MonoOuterCorner(config: primary.with(style: .concave)),
                                                                                MonoOuterCorner(config: primary.with(style: .convex))] }
    
    private func plateau(with primary: SocketConfig) -> [PrototypeTile] { [MonoPlateau(config: primary.with(style: .straight))] }
}
