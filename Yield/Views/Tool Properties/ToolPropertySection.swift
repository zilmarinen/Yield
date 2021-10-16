//
//  ToolPropertySection.swift
//
//  Created by Zack Brown on 02/10/2021.
//

import SwiftUI

struct ToolPropertySection<Content: View>: View {
    
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        
        self.content = content()
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
        
            VStack {
            
                content
            }
            .labelsHidden()
            .padding(YieldApp.Constants.padding)
            .background(Color(NSColor.unemphasizedSelectedContentBackgroundColor))
            .cornerRadius(YieldApp.Constants.cornerRadius)
        }
    }
}
