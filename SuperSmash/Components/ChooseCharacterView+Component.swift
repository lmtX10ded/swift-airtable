//
//  ChooseCharacterView+Component.swift
//  SuperSmash
//
//  Created by Zack Shapiro on 5/28/20.
//  Copyright © 2020 Zack Shapiro. All rights reserved.
//

import SwiftUI

struct ChooseCharacterComponent: UIComponent {
    
    var uniqueId: String
    
    let text: String
    
    func render() -> AnyView {
        ChooseCharacterView(text: text).toAny()
    }
    
}

struct ChooseCharacterView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .padding()
            .foregroundColor(.white)
    }
}
