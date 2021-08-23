//
//  InputCellModel.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/20/21.
//

import Foundation

typealias InputSectionArrayModel = [InputSectionModel]
struct InputSectionModel: Codable {
    let sectionTitle: String?
    var items: InputCellArrayModel
}

extension InputSectionModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.items == rhs.items
    }
}

typealias InputCellArrayModel = [InputCellModel]
struct InputCellModel: Codable {
    let id: Int
    let title, placeHolder: String?
    var value: String?
    var inputType: Int = 1
}

extension InputCellModel {
    func getInputType() -> CellInputType {
        switch inputType {
        case 1:
            return .normal
        case 2:
            return .phoneNumber
        case 3:
            return .email
        case 4:
            return .numeric
        default:
            assertionFailure("inputType ID is notValid")
            return .normal
        }
    }
}

extension InputCellModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        let equalID = (lhs.id == rhs.id)
        let equalValue = (lhs.value == rhs.value)
        return equalID && equalValue
    }
}
