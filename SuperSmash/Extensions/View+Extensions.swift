//
//  View+Extensions.swift
//  SuperSmash
//
//  Created by Zack Shapiro on 5/25/20.
//  Copyright © 2020 Zack Shapiro. All rights reserved.
//

import SwiftUI

/// An extension on `View` that we can all to generalize the view into an `AnyView` to use where we like.
extension View {
 
    func toAny() -> AnyView {
        AnyView(self)
    }
    
}

