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
    
    internal var output: Result<[String : FileWrapper], Error> = Result { throw ResultError.noResult }
    
    internal override init() {
        
        super.init()
        
        self.name = "Asset Cache"
        self.internalQueue.maxConcurrentOperationCount = 1
    }
    
    internal override func execute() {
        
        print("\u{001B}[37m[Generating \(name ?? "")]\u{001B}[0m\n")
        
        do {
            
            var files = try Dictionary.folder()
            
            let operations = [BuildingMeshingOperation(),
                              FenceMeshingOperation(),
                              FoliageMeshingOperation(),
                              FootpathMeshingOperation(),
                              SlopeMeshingOperation()]
            
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
            
            output = .success(files)
        }
        catch {
            
            output = .failure(error)
        }
        
        finish()
    }
    
    internal override func finish() {
        
        super.finish()
        
        guard let startDate,
              let finishDate else { return }
        
        let duration = String(format: "%.2f",
                              finishDate.timeIntervalSince(startDate))
        
        print("\u{001B}[37m[Finished Generating \(name ?? "")]\u{001B}[0m")
        print("\u{001B}[32m[\(duration) seconds]\u{001B}[0m\n")
    }
}
