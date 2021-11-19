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
    
    typealias TileBuilder = ((_ m0: SurfaceMaterial, _ style: BiscuitStyle, _ volume: Volume) -> ([PrototypeTile]))
    
    private func tiles(with material: SurfaceMaterial, styles: [BiscuitStyle], builder: TileBuilder) -> [PrototypeTile] {
        
        return [Volume.crown, .mantle].flatMap { volume in
                
            styles.flatMap { style in
                
                builder(material, style, volume)
            }
        }
    }
    
    private func edges(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = BiscuitStyle.allCases
        
        return tiles(with: material, styles: styles) { m0, style, volume in
            
            edges(with: .init(material: m0, style: style, volume: volume, type: .edge(.north)))
        }
    }
    
    private func grooves(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = [BiscuitStyle.concave, .convex]
        
        return tiles(with: material, styles: styles) { m0, style, volume in
            
            grooves(with: .init(material: m0, style: .straight, volume: volume, type: .corner(.northWest)))
        }
    }
    
    private func innerCorners(with material: SurfaceMaterial) -> [PrototypeTile] {
    
        let styles = [BiscuitStyle.concave, .convex]
        
        return tiles(with: material, styles: styles) { m0, style, volume in
            
            innerCorners(with: .init(material: m0, style: .straight, volume: volume, type: .corner(.southWest)))
        }
    }
    
    private func outerCorners(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = [BiscuitStyle.concave, .convex]
        
        return tiles(with: material, styles: styles) { m0, style, volume in
            
            outerCorners(with: .init(material: m0, style: .straight, volume: volume, type: .corner(.northWest)))
        }
    }
    
    private func plateau(with material: SurfaceMaterial) -> [PrototypeTile] {
        
        let styles = [BiscuitStyle.straight]
        
        return tiles(with: material, styles: styles) { m0, style, volume in
            
            plateau(with: .init(material: m0, style: .straight, volume: volume, type: .plateau))
        }
    }
}

extension MonoTilesetExportOperation {
    
    private func edges(with primary: SocketConfig) -> [PrototypeTile] { [MonoEdge(config: primary)] }
    
    private func grooves(with primary: SocketConfig) -> [PrototypeTile] { [MonoGroove(config: primary)] }
    
    private func innerCorners(with primary: SocketConfig) -> [PrototypeTile] { [MonoInnerCorner(config: primary)] }
    
    private func outerCorners(with primary: SocketConfig) -> [PrototypeTile] { [MonoOuterCorner(config: primary)] }
    
    private func plateau(with primary: SocketConfig) -> [PrototypeTile] { [MonoPlateau(config: primary)] }
}
