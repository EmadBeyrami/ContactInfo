//
//  GeneralTypeAlias.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/20/21.
//

import Foundation

// MARK: Completion Closures
typealias Completion = (() -> Void)
typealias DataCompletion<T> = ((T) -> Void)
typealias BoolCompletion = DataCompletion<Bool>
typealias StringCompletion = DataCompletion<String>
