//
//  AirtableService.swift
//  SuperSmash
//
//  Created by Zack Shapiro on 5/25/20.
//  Copyright © 2020 Zack Shapiro. All rights reserved.
//

import Foundation
import SwiftAirtable

struct AirtableService {
    
    private static let apiKey = "keycrm6WEmQcMFGGc" // dont ship this!
    private static let apiBaseUrl = "https://api.airtable.com/v0/app4zFeqFCgr4uOAq" // dont ship this!
    
    static func getCharacters(completion: @escaping (Result<[SmashCharacter], Error>) -> Void) {
        let airtable = Airtable(apiKey: apiKey, apiBaseUrl: apiBaseUrl, schema: SmashCharacter.schema)
        
        airtable.fetchAll(table: SmashCharacter.airtableViewName) { (characters: [SmashCharacter], error) in
         if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(characters))
            }
        }
    }
    
    static func getViews(completion: @escaping (Result<[UIComponent], Error>) -> Void) {
        let airtable = Airtable(apiKey: apiKey, apiBaseUrl: apiBaseUrl, schema: ATView.schema)
        
        airtable.fetchAll(table: ATView.airtableViewName) { (views: [ATView], error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let components = parseViewsToComponents(views: views)
                completion(.success(components))
            }
        }
    }
    
    static func updateCount(for character: SmashCharacter, completion: @escaping (Error?) -> Void) {
        let airtable = Airtable(apiKey: apiKey, apiBaseUrl: apiBaseUrl, schema: SmashCharacter.schema)
        
        var updatedCharacter = character
        updatedCharacter.count += 1
        
        airtable.updateObject(with: updatedCharacter, inTable: SmashCharacter.airtableViewName) { character, error in
//            print(error)
            completion(error)
        }
    }
    
    private static func parseViewsToComponents(views: [ATView]) -> [UIComponent] {
        views
            .sorted(by: { $0.position < $1.position })
            .map {
                switch $0.viewType {
                case .battleType:
                    return BattleComponent(uniqueId: $0.id, text: $0.text)
                
                case .chooseCharacter:
                    return ChooseCharacterComponent(uniqueId: $0.id, text: $0.text)
                }
        }
    }
}
