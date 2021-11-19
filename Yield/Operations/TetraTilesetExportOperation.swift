//
//  TetraTilesetExportOperation.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Foundation
import Meadow
import PeakOperation

class TetraTilesetExportOperation: ConcurrentOperation, ConsumesResult, ProducesResult {
    
    public var input: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    override func execute() {
        
        do {
            
            let (tileset, wrappers) = try input.get()
            
            let prototypes = plateau()
            
            let exportOperation = PrototypeTileExportOperation(type: .tetra, prototypes: prototypes, tileCache: tileset, fileCache: wrappers)
            
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

extension TetraTilesetExportOperation {
    
    private func plateau() -> [PrototypeTile] {
        
        let materials = SurfaceMaterial.solids
        let styles = [BiscuitStyle.concave, .convex]
        
        let primary = materials[0]
        let secondary = materials[1]
        let tertiary = materials[2]
        let quaternary = materials[3]
        
        return [Volume.crown, .mantle].flatMap { volume in
            
            styles.flatMap { style in
            
                plateau(with: .init(material: primary, style: style, volume: volume, type: .corner(.northWest)),
                        secondary: .init(material: secondary, style: style, volume: volume, type: .corner(.northEast)),
                        tertiary: .init(material: tertiary, style: style, volume: volume, type: .corner(.southEast)),
                        quaternary: .init(material: quaternary, style: style, volume: volume, type: .corner(.southWest)))
            }
        }
    }
}

extension TetraTilesetExportOperation {
    
    private func plateau(with primary: SocketConfig, secondary: SocketConfig, tertiary: SocketConfig, quaternary: SocketConfig) -> [PrototypeTile] { [TetraPlateau(primary: primary,
                                                                                                                                                                   secondary: secondary.with(volume: .crown),
                                                                                                                                                                   tertiary: tertiary.with(volume: .crown),
                                                                                                                                                                   quaternary: quaternary.with(volume: .crown)),
    
                                                                                                                                                      TetraPlateau(primary: primary,
                                                                                                                                                                   secondary: secondary.with(volume: .mantle),
                                                                                                                                                                   tertiary: tertiary.with(volume: .crown),
                                                                                                                                                                   quaternary: quaternary.with(volume: .crown)),
                                                                                                                                                      
                                                                                                                                                      TetraPlateau(primary: primary,
                                                                                                                                                                   secondary: secondary.with(volume: .mantle),
                                                                                                                                                                   tertiary: tertiary.with(volume: .mantle),
                                                                                                                                                                   quaternary: quaternary.with(volume: .crown)),
                                                                                                                                                      
                                                                                                                                                      TetraPlateau(primary: primary,
                                                                                                                                                                   secondary: secondary.with(volume: .mantle),
                                                                                                                                                                   tertiary: tertiary.with(volume: .crown),
                                                                                                                                                                   quaternary: quaternary.with(volume: .mantle)),
                                                                                                                                                      
                                                                                                                                                      TetraPlateau(primary: primary,
                                                                                                                                                                   secondary: secondary.with(volume: .crown),
                                                                                                                                                                   tertiary: tertiary.with(volume: .mantle),
                                                                                                                                                                   quaternary: quaternary.with(volume: .mantle))] }
}

