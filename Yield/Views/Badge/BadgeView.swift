//
//  BadgeView.swift
//
//  Created by Zack Brown on 23/09/2021.
//

import SwiftUI

struct BadgeView: View {
    
    let model: BadgeModel
    
    var body: some View {
        
        Text(model.title)
            .font(.system(size: 10, weight: .regular))
            .foregroundColor(model.textColor)
            .padding(YieldApp.Constants.edgeInsets)
            .background(model.color)
            .cornerRadius(YieldApp.Constants.padding)
    }
}
