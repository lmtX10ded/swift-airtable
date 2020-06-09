//
//  CharacterView.swift
//  SuperSmash
//
//  Created by Zack Shapiro on 5/27/20.
//  Copyright © 2020 Zack Shapiro. All rights reserved.
//

import SwiftUI

/// A component that takes data from the server and is able to render it into an `AnyView`.
struct CharacterComponent: UIComponent {
    
    var uniqueId: String
    
    let character: SmashCharacter
    let characterTapped: (SmashCharacter) -> Void
    
    init(_ character: SmashCharacter, characterTapped: @escaping (SmashCharacter) -> Void) {
        self.uniqueId = character.id
        self.character = character
        self.characterTapped = characterTapped
    }
    
    func render() -> AnyView {
        CharacterView(
            character: character,
            characterTapped: characterTapped
        ).toAny()
    }
    
}

// Anything that confirms to UIComponent, we can call render on without having to submit new builds to Apple, completely controlled by the Airtable
//let components = [UIComponent]
//
//ForEach(components, id: \.uniqueId) { component in
//    component.render()
//}

















// MARK: - CharacterView

struct CharacterView: View {
    
    let character: SmashCharacter
    let characterTapped: (SmashCharacter) -> Void
    
    var body: some View {
        Button(action: { self.characterTapped(self.character) }) {
            ZStack(alignment: .trailing) {
                Image(systemName: "\(character.count).circle.fill")
                    .frame(width: 20, height: 20)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.top, -68)
                    .padding(.trailing, -6)
                
                HStack {
                    Spacer()
                    VStack(spacing: 12) {
                        ImageViewContainer(imageUrl: character.imageUrl)
                        
                        Text(character.name)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.vertical, 16)
                .background(Color(UIColor.systemFill))
                .cornerRadius(12)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CharacterView_Previews: PreviewProvider {
    
    static let imageUrl = "https://p93.f3.n0.cdn.getcloudapp.com/items/8LujX1dk/Screen%20Shot%202020-05-27%20at%2010.01.10%20PM.png?v=1d6f1bad439674def6755d5abac7a744"
    
    static var previews: some View {
        CharacterView(
            character: SmashCharacter(
                id: "1",
                name: "Pikachu",
                description: "Pika Pika!",
                imageUrl: imageUrl,
                row: 0,
                column: 0,
                count: 3
            ),
            characterTapped: { _ in }
        )
    }
}

// Win component goes here
