//
//  ToolPropertyView.swift
//
//  Created by Zack Brown on 30/09/2021.
//

import SwiftUI

struct ToolPropertyView<Content: View>: View {
    
    let title: String
    let color: Color
    let content: Content

    init(title: String, color: Color, @ViewBuilder content: () -> Content) {
        
        self.title = title
        self.color = color
        self.content = content()
    }

    var body: some View {
        
        HStack {
            
            Group {
            
                Circle()
                    .fill(color)
                    .frame(width: YieldApp.Constants.cornerRadius, height: YieldApp.Constants.cornerRadius)
                
                Text(title)
                    .font(.subheadline)
            }
            
            Spacer()
            
            content
        }
    }
}
