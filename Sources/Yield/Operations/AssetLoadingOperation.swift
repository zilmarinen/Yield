//
//  AssetLoadingOperation.swift
//
//  Created by Zack Brown on 13/07/2024.
//

import Foundation
import PeakOperation

public final class AssetLoadingOperation: ConcurrentOperation {
    
    private let assets: [Asset]
    
    public init(assets: [Asset]) {
     
        self.assets = assets
    }
    
    public override func execute() {
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: name ?? String(describing: self),
                                          attributes: .concurrent)
        
        let  operations = assets.map { $0.operation }
        
        progress.totalUnitCount = Int64(operations.count)
        
        operations.forEach {
            
            group.enter()
            
            $0.addDidFinishBlock { [weak self] in
                
                guard let self else { return }
                
                queue.async(flags: .barrier) {
                    
                    self.progress.completedUnitCount += 1
                    
                    group.leave()
                }
            }
            
            $0.enqueue(on: internalQueue)
        }
        
        group.wait()
        
        finish()
    }
}
