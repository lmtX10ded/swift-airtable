//
//  SelectionView.swift
//  SuperSmash
//
//  Created by Zack Shapiro on 5/27/20.
//  Copyright © 2020 Zack Shapiro. All rights reserved.
//

import SwiftUI


struct SelectionView: View {
    
    @EnvironmentObject var state: AppState

    @State private var buttonText: String = "Select!"
    
    let updateCount: () -> Void
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                imageView
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(self.character == nil ? "Player 1 Select" : character!.name)
                        .font(.headline)
                    
                    Text(self.character == nil ? "" : character!.description)
                    
                    Button(action: {
                        self.buttonText = "Selected!"
                        self.updateCount()
                    }) {
                        HStack {
                            Spacer()
                            Text(self.buttonText)
                                .font(.headline)
                                .foregroundColor(Color.black)
                            Spacer()
                        }
                        .frame(height: 48)
                        .background(Color.white)
                        .cornerRadius(24)
                    }.buttonStyle(PlainButtonStyle())
                }
                .foregroundColor(Color.white)
            }
        }
        .padding()
        .background(Color(UIColor.systemRed))
        .cornerRadius(12)
    }
    
    // MARK: - Private Properties
    
    private var character: SmashCharacter? {
        state.selectedCharacter
    }
    
    private var imageView: AnyView {
        if let character = state.selectedCharacter {
            return ImageViewContainer(imageUrl: character.imageUrl).toAny()
        } else {
            return Image(systemName: "person")
                .resizable()
                .padding(18)
                .frame(width: 64, height: 64)
                .background(Color.white)
                .cornerRadius(32)
                .toAny()
        }
    }
    
}

//struct SelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectionView(character: ))
//    }
//}

// Long button component goes here
