//
//  ContentView.swift
//  SuperSmash
//
//  Created by Zack Shapiro on 5/21/20.
//  Copyright © 2020 Zack Shapiro. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject var state: AppState
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(state.viewComponents, id: \.uniqueId) {
                $0.render()
            }
                      
            HStack(alignment: .top, spacing: 12) {
                ForEach(firstRowComponents, id: \.uniqueId) {
                    $0.render()
                }
            }

            HStack(alignment: .top, spacing: 12) {
                ForEach(secondRowComponents, id: \.uniqueId) {
                    $0.render()
                }
            }
            
            Spacer()
            
            SelectionView(updateCount: self.updateCount)
                .environmentObject(state)
        }
        .padding()
        .background(Color.black)
        .onAppear {
            self.refreshContent()
        }
        .onReceive(timer) { _ in
            self.refreshContent()
        }
    }
    
    // MARK: - Private Properties
    
    // Auto-refresh characters every 5 seconds.
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    private var firstRowComponents: [UIComponent] {
        state.characters
            .filter { $0.row == 0 }
            .sorted(by: { $0.column < $1.column })
            .map {
                CharacterComponent($0, characterTapped: self.characterTapped(_:))
            }
    }
    
    private var secondRowComponents: [UIComponent] {
        state.characters
            .filter { $0.row == 1 }
            .sorted(by: { $0.column < $1.column })
            .map {
                CharacterComponent($0, characterTapped: self.characterTapped(_:))    
            }
    }

    // MARK: - Private Functions
    
    private func characterTapped(_ character: SmashCharacter) {
        state.selectedCharacter = character
    }
    
    private func refreshContent() {
        getViews()
        getCharacters()
    }
    
    private func getViews() {
        AirtableService.getViews { result in
            switch result {
            case .success(let viewComponents):
                DispatchQueue.main.async {
                    self.state.viewComponents = viewComponents
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getCharacters() {
        AirtableService.getCharacters { result in
            switch result {
            case .success(let characters):
                DispatchQueue.main.async {
                    self.state.characters = characters
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateCount() {
        guard let selectedCharacter = state.selectedCharacter else { return }
        
        AirtableService.updateCount(for: selectedCharacter) { error in
            if let error = error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.refreshContent()
            }
        }
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
