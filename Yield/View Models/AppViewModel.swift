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
