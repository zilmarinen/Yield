//
//  TilesetExportOperation.swift
//
//  Created by Zack Brown on 31/10/2021.
//

import Foundation
import PeakOperation

class TilesetExportOperation: ConcurrentOperation, ProducesResult {
    
    public var output: Result<(Tileset, [String : FileWrapper]), Error> = Result { throw ResultError.noResult }
    
    override func execute() {
        
        let mono = MonoTilesetExportOperation()
        let duo = DuoTilesetExportOperation()
        let tri = TriTilesetExportOperation()
        let tetra = TetraTilesetExportOperation()
        
        mono.passesResult(to: duo)
            .passesResult(to: tri)
            .passesResult(to: tetra).enqueue(on: internalQueue) { [weak self] result in
                
            guard let self = self else { return }
            
            switch result {
                
            case .failure(let error): self.output = .failure(error)
            case .success(let output): self.output = .success(output)
            }
                
            self.finish()
        }
    }
}