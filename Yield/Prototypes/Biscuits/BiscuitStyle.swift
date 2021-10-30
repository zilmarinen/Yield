//
//  BiscuitStyle.swift
//
//  Created by Zack Brown on 28/10/2021.
//

enum BiscuitStyle: String, CaseIterable, Identifiable {
    
    case rounded
    case squared
    
    var id: String { rawValue }
}
