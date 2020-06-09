//
//  SmashCharacter.swift
//  SuperSmash
//
//  Created by Zack Shapiro on 5/26/20.
//  Copyright © 2020 Zack Shapiro. All rights reserved.
//

import Foundation
import SwiftAirtable

struct SmashCharacter: Identifiable, Equatable {
    
    static let airtableViewName = "characters"
    
    /// This is the airtable ID field, This field **must** be public.
    var id: String = ""
    
    private (set) var name: String = ""
    private (set) var description: String = ""
    private (set) var imageUrl: String = ""
    private (set) var row: Int = 0
    private (set) var column: Int = 0
    var count: Int = 0
    private (set) var viewType: String = ""
    
    // MARK: - Airtable Fields
    
    enum AirtableField: String, CaseIterable {
        case name
        case description
        case imageUrl
        case row
        case column
        case count
        case viewType
        
        var fieldType: AirtableTableSchemaFieldKey.KeyType {
            switch self {
            case .name:        return .singleLineText
            case .description: return .singleLineText
            case .imageUrl:    return .singleLineText
            case .row:         return .number
            case .column:      return .number
            case .count:       return .number
            case .viewType:    return .singleSelect
            }
        }
    }
}

extension SmashCharacter: AirtableObject {
    
    init(withId id: String, populatedTableSchemaKeys tableSchemaKeys: [AirtableTableSchemaFieldKey : AirtableValue]) {
        self.id = id
        
        tableSchemaKeys.forEach { element in
            guard let column = AirtableField(rawValue: element.key.fieldName) else { return }
            switch column {
            case .name:        self.name = element.value.stringValue
            case .description: self.description = element.value.stringValue
            case .imageUrl:    self.imageUrl = element.value.stringValue
            case .row:         self.row = element.value.intValue
            case .column:      self.column = element.value.intValue
            case .count:       self.count = element.value.intValue
            case .viewType:    self.viewType = element.value.stringValue
            }
        }
    }
   
    /// Connects the names of the columns and their string values to the data type that's contained in the column.
    static var fieldKeys: [(fieldName: String, fieldType: AirtableTableSchemaFieldKey.KeyType)] {
        AirtableField.allCases.compactMap {
            (fieldName: $0.rawValue, fieldType: $0.fieldType)
        }
    }
    
    func value(forKey key: AirtableTableSchemaFieldKey) -> AirtableValue? {
        switch key {
        case AirtableTableSchemaFieldKey(fieldName: AirtableField.name.rawValue, fieldType: .singleLineText):
            return self.name
        
        case AirtableTableSchemaFieldKey(fieldName: AirtableField.description.rawValue, fieldType: .singleLineText):
            return self.description
            
        case AirtableTableSchemaFieldKey(fieldName: AirtableField.imageUrl.rawValue, fieldType: .singleLineText):
            return self.imageUrl
        
        case AirtableTableSchemaFieldKey(fieldName: AirtableField.row.rawValue, fieldType: .number):
            return self.row
            
        case AirtableTableSchemaFieldKey(fieldName: AirtableField.column.rawValue, fieldType: .number):
            return self.column
        
        case AirtableTableSchemaFieldKey(fieldName: AirtableField.count.rawValue, fieldType: .number):
            return self.count
        
        case AirtableTableSchemaFieldKey(fieldName: AirtableField.viewType.rawValue, fieldType: .singleSelect):
            return self.viewType
        
        default: return nil
        }
    }

}
