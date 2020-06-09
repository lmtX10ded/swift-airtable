//
//  AppState.swift
//  SuperSmash
//
//  Created by Zack Shapiro on 5/27/20.
//  Copyright © 2020 Zack Shapiro. All rights reserved.
//

import SwiftUI

final class AppState: ObservableObject {

    @Published var characters: [SmashCharacter] = []
    @Published var selectedCharacter: SmashCharacter? = nil
    
    @Published var viewComponents: [UIComponent] = []
    
}
