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
    
    init() {
        
        //
    }
    
    init(fileWrapper: FileWrapper) throws {
        
        do {
            
            //
        }
        catch {
            
            throw error
        }
    }
    
    func fileWrapper() throws -> FileWrapper {
        
        do {
            
            return .init(directoryWithFileWrappers: [:])
        }
        catch {
            
            throw error
        }
    }
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
            
            guard let url = panel.url else { return }
            
//            let exportOperation = TilemapExportOperation(url: url, tilemap: tilemap)
//            let writeOperation = WriteOperation(url: url);
//
//            let progress = exportOperation.passesResult(to: writeOperation).enqueueWithProgress(on: operationQueue) { result in
//
//                DispatchQueue.main.async { [weak self] in
//
//                    guard let self = self else { return }
//
//                    self.viewState = .idle
//                }
//            }
            
            //viewState = .exporting(progress: progress)
            
        default: break
        }
    }
}
