//
//  Volume.swift
//
//  Created by Zack Brown on 27/10/2021.
//

enum Volume: String, CaseIterable, Identifiable {
    
    case empty
    case crown
    case throne
    case mantle
    
    var id: String { rawValue }
}
