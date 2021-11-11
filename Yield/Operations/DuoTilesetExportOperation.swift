//
//  DuoTilesetExportOperation.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Foundation
import Meadow
import PeakOperation

class DuoTilesetExportOperation: ConcurrentOperation, ConsumesResult, ProducesResult {
    
    public var input: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    override func execute() {
        
        do {
            
            let (tileset, wrappers) = try input.get()
            
            var prototypes: [PrototypeTile] = []
            
            for material in SurfaceMaterial.solids {
                
                prototypes.append(contentsOf: grooves(with: material))
                prototypes.append(contentsOf: innerCorners(with: material))
                prototypes.append(contentsOf: outerCorners(with: material))
                prototypes.append(contentsOf: plateau(with: material))
            }
            
            let exportOperation = PrototypeTileExportOperation(type: .duo, prototypes: prototypes, tileCache: tileset, fileCache: wrappers)
            
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
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}

extension DuoTilesetExportOperation {
    
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

extension DuoTilesetExportOperation {
    
    private func grooves(with primary: SocketConfig) -> [PrototypeTile] { [] }
    
    private func innerCorners(with primary: SocketConfig) -> [PrototypeTile] { [] }
    
    private func outerCorners(with primary: SocketConfig) -> [PrototypeTile] { [] }
    
    private func plateau(with primary: SocketConfig) -> [PrototypeTile] { [DuoPlateau(primary: primary, secondary: primary)] }
}
