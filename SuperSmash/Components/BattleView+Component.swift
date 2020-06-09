//
//  BattleView+Component.swift
//  SuperSmash
//
//  Created by Zack Shapiro on 5/28/20.
//  Copyright © 2020 Zack Shapiro. All rights reserved.
//

import SwiftUI

struct BattleComponent: UIComponent {
    var uniqueId: String
    
    let text: String
    
    func render() -> AnyView {
        BattleView(text: text).toAny()
    }
    
}

struct BattleView: View {
    
    let text: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .font(.headline)
                .foregroundColor(Color.black)
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemYellow))
        .cornerRadius(12)
    }
    
}
