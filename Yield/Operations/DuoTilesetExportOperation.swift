//
//  DuoTilesetExportOperation.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Foundation
import PeakOperation

class DuoTilesetExportOperation: ConcurrentOperation, ConsumesResult, ProducesResult {
    
    public var input: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    override func execute() {
        
        do {
            
            var (tileset, wrappers) = try input.get()
            
            var id = tileset.tiles.count
            let encoder = JSONEncoder()
            
            //
            
            output = .success((tileset, wrappers))
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}
