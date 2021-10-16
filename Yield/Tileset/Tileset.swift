//
//  Tileset.swift
//
//  Created by Zack Brown on 16/10/2021.
//

import Foundation

class Tileset: ObservableObject {
    
    enum Style: String, CaseIterable, Identifiable {
        
        case block
        case layered
        
        var id: String { rawValue }
    }
    
    enum Inset: String, CaseIterable, Identifiable {
        
        case bottom
        case none
        case top
        
        var id: String { rawValue }
    }
    
    @Published var name: String = "Tileset"
    @Published var tile: Int = 0
    
    @Published var style: Style = .layered
    @Published var inset: Inset = .none
}
