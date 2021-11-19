//
//  AppViewModel.swift
//
//  Created by Zack Brown on 15/10/2021.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
    
    enum ViewState {
        
        case editing
        case exporting(progress: Progress)
    }
    
    @ObservedObject var editorModel = EditorViewModel()
    
    @Published var viewState: ViewState = .editing
    
    lazy var operationQueue: OperationQueue = {
            
        let queue = OperationQueue()
        
        queue.maxConcurrentOperationCount = 1
        
        return queue
    }()
}

extension AppViewModel {
    
    func export() {
        
        let panel = NSOpenPanel()
        
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.canCreateDirectories = true
        panel.prompt = "Export"
        
        switch panel.runModal() {
            
        case .OK:
            
            guard let url = panel.url else {
                
                DispatchQueue.main.async { [weak self] in

                    guard let self = self else { return }

                    self.viewState = .editing
                }
                
                return
            }
            
            let exportOperation = TilesetExportOperation()
            let writeOperation = WriteOperation(url: url)
            
            let progress = exportOperation.passesResult(to: writeOperation).enqueueWithProgress(on: operationQueue) { result in

                DispatchQueue.main.async { [weak self] in

                    guard let self = self else { return }

                    self.viewState = .editing
                }
            }
            
            viewState = .exporting(progress: progress)
            
        default: break
        }
    }
}
