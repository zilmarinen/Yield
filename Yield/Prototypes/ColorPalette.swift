//
//  ColorPalette.swift
//
//  Created by Zack Brown on 27/10/2021.
//

import Euclid

struct ColorPalette {
    
    let primary: Color
    let secondary: Color
    let tertiary: Color
    let quaterniary: Color
}

extension ColorPalette {
    
    static let air = ColorPalette(primary: .clear, secondary: .clear, tertiary: .clear, quaterniary: .clear)
    
    static let dirt = ColorPalette(primary: Color(0.776, 0.835, 0.494),
                                   secondary: Color(0.807, 0.989, 0.815),
                                   tertiary: Color(0.764, 0.407, 0.223),
                                   quaterniary: Color(0.670, 0.427, 0.137))
    
    static let sand = ColorPalette(primary: Color(0.776, 0.835, 0.494),
                                   secondary: Color(0.807, 0.989, 0.815),
                                   tertiary: Color(0.764, 0.407, 0.223),
                                   quaterniary: Color(0.670, 0.427, 0.137))
    
    static let stone = ColorPalette(primary: Color(0.392, 0.423, 0.372),
                                    secondary: Color(0.329, 0.337, 0.333),
                                    tertiary: Color(0.439, 0.345, 0.321),
                                    quaterniary: Color(0.313, 0.231, 0.239))
    
    static let undergrowth = ColorPalette(primary: Color(0.776, 0.835, 0.494),
                                          secondary: Color(0.807, 0.989, 0.815),
                                          tertiary: Color(0.764, 0.407, 0.223),
                                          quaterniary: Color(0.670, 0.427, 0.137))
}
