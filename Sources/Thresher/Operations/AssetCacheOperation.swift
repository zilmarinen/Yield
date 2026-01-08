//
//  AssetCacheOperation.swift
//  Yield
//
//  Created by Zack Brown on 07/01/2026.
//

import Foundation
import PeakOperation

internal class AssetCacheOperation: ConcurrentOperation,
                                    ProducesResult,
                                    @unchecked Sendable {
    
    typealias MeshingResult = (files: [String : FileWrapper],
                               folder: String)
    
    internal var output: Result<MeshingResult, Error> = Result { throw ResultError.noResult }
    
    internal override init() {
        
        super.init()
        
        self.name = "Asset Cache"
        self.internalQueue.maxConcurrentOperationCount = 1
    }
    
    internal override func execute() {
        
        do {
            
            var files = try folder()
            
            let operations = [EdificeMeshingOperation(),
                              FoliageMeshingOperation(),
                              FootpathMeshingOperation(),
                              StepMeshingOperation()]
            
            let group = DispatchGroup()
            
            for operation in operations {
                
                group.enter()
                
                operation.enqueue(on: internalQueue) { result in
                    
                    switch result {
                        
                    case .success(let contents):
                        
                        let fileWrapper = FileWrapper(directoryWithFileWrappers: contents.files)
                        
                        files[contents.folder] = fileWrapper
                        
                    case .failure(let error):
                        
                        fatalError("Error: [\(error.localizedDescription)]")
                    }
                    
                    group.leave()
                }
            }
            
            group.wait()
            
            output = .success((files,
                               .assets))
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}

extension AssetCacheOperation {
    
    internal func folder() throws -> [String : FileWrapper] {
        
        let contents = Contents.default
        
        let encoder = JSONEncoder.default
        
        let jsonData = try encoder.encode(contents)
        
        let jsonWrapper = FileWrapper(regularFileWithContents: jsonData)
        
        return [.contents : jsonWrapper]
    }
}
