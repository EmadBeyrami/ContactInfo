//
//  DataManager.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/22/21.
//

import Foundation

protocol DataManagable {
    func write<T: Codable>(key: UserDefaultsConfig.UserDefaultsKey, value: T) throws
    func read<T: Codable>(key: UserDefaultsConfig.UserDefaultsKey) throws -> T
}

class DataManager: DataManagable {
    
    enum Error: Swift.Error {
        case writtingFailed
        case fileNotExists
        case readingFailed
    }
    
    let fileManager: UserDefaults
    
    public static let shared: DataManager = DataManager()
    
    init(fileManager: UserDefaults = .standard) {
        self.fileManager = fileManager
    }
    
    private struct Wrapper<T>: Codable where T: Codable {
        let wrapper: T
    }
    
    func read<T: Codable>(key: UserDefaultsConfig.UserDefaultsKey) throws -> T {
        guard let data = fileManager.object(forKey: key.rawValue) as? Data else {
            // Return defaultValue when no data in UserDefaults
            return key.defaultValue as! T
        }
        do {
            // Convert data to the desire data type
            let value = try JSONDecoder().decode(Wrapper<T>.self, from: data)
            return value.wrapper
        } catch {
            throw Error.readingFailed
        }
    }
    
    func write<T: Codable>(key: UserDefaultsConfig.UserDefaultsKey, value: T) throws {
        do {
            let data = try JSONEncoder().encode(Wrapper(wrapper: value))
            fileManager.set(data, forKey: key.rawValue)
        } catch {
            fileManager.removeObject(forKey: key.rawValue)
            print(error)
            throw Error.writtingFailed
        }
    }
    
}
