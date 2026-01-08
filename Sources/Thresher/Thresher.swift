//
//  Thresher.swift
//  Yield
//
//  Created by Zack Brown on 07/01/2026.
//

import Foundation

internal class Thresher {
    
    internal let group = DispatchGroup()
    internal let queue = OperationQueue()
    
    internal func execute() {
        
        // MARK: Setup
        
        let fileManager = FileManager.default
        
        let path = fileManager.currentDirectoryPath + .directory + .assets
        let url = URL(fileURLWithPath: path)
        
        remove(file: path)
        
        // MARK: Meshing
        
        let operation = AssetCacheOperation()
        
        group.enter()
        
        operation.enqueue(on: queue) { [weak self] result in
        
            guard let self else { return }
            
            switch result {
                
            case .success(let contents):
                
                let fileWrapper = FileWrapper(directoryWithFileWrappers: contents)
                
                self.write(fileWrapper: fileWrapper,
                           to: url)
                
            case .failure(let error):
                
                print("Error: [\(error.localizedDescription)]")
            }
            
            self.group.leave()
        }
        
        group.wait()
    }
}

extension Thresher {
    
    private func remove(file path: String) {
        
        guard FileManager.default.fileExists(atPath: path) else { return }
        
        do {
            
            try FileManager.default.removeItem(atPath: path)
        }
        catch {
            
            print("Error: [\(error.localizedDescription)]")
        }
    }
    
    private func write(fileWrapper: FileWrapper,
                       to url: URL) {
        
        do {
            
            try fileWrapper.write(to: url,
                                  originalContentsURL: nil)
        }
        catch {
            
            print("Error: [\(error.localizedDescription)]")
        }
    }
}
