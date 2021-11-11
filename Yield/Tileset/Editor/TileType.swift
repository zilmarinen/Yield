//
//  TileType.swift
//
//  Created by Zack Brown on 03/11/2021.
//

import Foundation

enum TileType: String, CaseIterable, Identifiable {
    
    case mono
    case duo
    case tri
    case tetra
    
    var id: String { rawValue }
}
