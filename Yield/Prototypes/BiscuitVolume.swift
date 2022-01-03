//
//  BiscuitVolume.swift
//
//  Created by Zack Brown on 27/12/2021.
//

import Meadow

public enum BiscuitVolume: String, CaseIterable, Codable, Identifiable {
    
    public static var solids: [BiscuitVolume] = [.throne,
                                                 .crown]
    
    case empty
    case throne
    case crown
    case mantle
    
    public var id: String { rawValue }
}
