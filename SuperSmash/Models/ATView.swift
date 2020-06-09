//
//  ATView.swift
//  SuperSmash
//
//  Created by Zack Shapiro on 5/28/20.
//  Copyright © 2020 Zack Shapiro. All rights reserved.
//

//import Foundation
import SwiftAirtable

enum ViewType: String {
    case battleType
    case chooseCharacter
}

struct ATView: Equatable {
    
    static let airtableViewName = "views"
    
    /// this is the airtable ID field, This field **must** be public
    var id: String = ""
    
    private var _viewType: String = ""
    var viewType: ViewType {
        ViewType(rawValue: _viewType) ?? .battleType
    }
    
    private (set) var position: Int = 0
    private (set) var text: String = ""
    
    // MARK: - Airtable Fields
    
    enum AirtableField: String, CaseIterable {
        case viewType
        case position
        case text
        
        var fieldType: AirtableTableSchemaFieldKey.KeyType {
            switch self {
            case .viewType: return .singleSelect
            case .position: return .number
            case .text: return .singleLineText
            }
        }
    }
}

// MARK: - Protocol Extension

extension ATView: AirtableObject {

    init(withId id: String, populatedTableSchemaKeys tableSchemaKeys: [AirtableTableSchemaFieldKey : AirtableValue]) {
        self.id = id
        
        tableSchemaKeys.forEach { element in
            guard let column = AirtableField(rawValue: element.key.fieldName) else { return }
            switch column {
            case .viewType: self._viewType = element.value.stringValue
            case .position: self.position = element.value.intValue
            case .text: self.text = element.value.stringValue
            }
        }
    }
    
    static var fieldKeys: [(fieldName: String, fieldType: AirtableTableSchemaFieldKey.KeyType)] {
        AirtableField.allCases.compactMap { (fieldName: $0.rawValue, fieldType: $0.fieldType) }
    }
    
    func value(forKey key: AirtableTableSchemaFieldKey) -> AirtableValue? {
        return nil
    }

}
