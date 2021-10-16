//
//  ToolPropertyGroupModel.swift
//
//  Created by Zack Brown on 03/10/2021.
//

import SwiftUI

struct ToolPropertyGroupModel {
    
    let title: String
    let imageName: String?
    let badge: BadgeModel?
    
    init(title: String, imageName: String? = nil, badge: BadgeModel? = nil) {
        
        self.title = title
        self.imageName = imageName
        self.badge = badge
    }
}
