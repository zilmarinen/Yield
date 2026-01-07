//
//  AssetCacheOperation.swift
//  Yield
//
//  Created by Zack Brown on 07/01/2026.
//

import Foundation
import PeakOperation

internal class AssetCacheOperation: MeshingOperation,
                                    @unchecked Sendable {
    
    internal override init() {
        
        super.init()
        
        self.name = "Asset Cache"
        self.internalQueue.maxConcurrentOperationCount = 1
    }
    
    internal override func execute() {
        
        super.execute()
        
        do {
            
            var files = try folder()
            
            let operations = [FoliageMeshingOperation(),
                              FootpathMeshingOperation()]
            
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
                               Thresher.Constant.assets))
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
}
