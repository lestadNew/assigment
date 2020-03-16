//
//  ArchiveService.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import Foundation

class ArchiveService {
    
    static let standart = ArchiveService()
    
    let userDefault: UserDefaults
    
    private lazy var jsonDecoder = JSONDecoder()
    private lazy var jsonEncoder = JSONEncoder()
    
    /// Create a new instance of ArchiveService.
    ///
    /// - Parameter userDefault: Custom UserDefaults storage. Default is `standard`
    init(userDefault: UserDefaults = .standard) {
        self.userDefault = userDefault
    }
    
    // MARK: Set

    /// Set the model of the specified key
    ///
    /// - Parameters:
    ///   - model: The object model to store in the defaults database
    ///   - key: The key with which to associate the value.
    /// - Returns: true if the data was saved successfully to disk, otherwise false.
    @discardableResult
    func set<Model: Codable>(_ model: Model, forKey key: Key) -> Bool {
        do {
            let data = try self.jsonEncoder.encode(model)
            self.userDefault.set(data, forKey: key.rawValue)
            return self.userDefault.synchronize()
        }
        catch {
            debugPrint("\(#function) with error: \(error)")
            return false
        }
    }
    
    /// Set the models of the specified key
    ///
    /// - Parameters:
    ///   - models: The objects models to store in the defaults database
    ///   - key: The keys with which to associate the value.
    func set<Model: Codable>(models: [Model], forKey key: Key) {
        do {
            let data: Data = try NSKeyedArchiver.archivedData(withRootObject: models, requiringSecureCoding: false)
            self.userDefault.set(data, forKey: key.rawValue)
            self.userDefault.synchronize()
        } catch {
            debugPrint(#function)
        }
    }
    
    // MARK: Get
    
    /// Returns the object model associated with the specified key
    ///
    /// - Parameter key: A key in the current user‘s defaults database.
    /// - Returns: The object model associated with the specified key, or nil if the key does not exist or its value is not a data object.
    func model<Model: Codable>(forKey key: Key) -> Model? {
        guard let data = self.userDefault.data(forKey: key.rawValue) else { return nil }
        do {
            return try self.jsonDecoder.decode(Model.self, from: data)
        } catch {
            debugPrint("\(#function) with error: \(error)")
            return nil
        }
    }
    
    /// Returns the array of object model associated with the specified key
    ///
    /// - Parameter key: A key in the current user‘s defaults database.
    /// - Returns: The objects models associated with the specified key, or nil if the key does not exist or its value is not a data object.
    func models<Model: Codable>(type: Model.Type, forKey key: Key) -> [Model]? {
        guard let data = userDefault.object(forKey: key.rawValue) as? Data else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Model]
        } catch {
            debugPrint(#function)
            return nil
        }
    }
    
    // MARK: Remove
    /// Removes the value of the specified default key
    ///
    /// - Parameter key: The key whose value you want to remove
    func removeObject(forKey key: Key) {
        self.userDefault.removeObject(forKey: key.rawValue)
        self.userDefault.synchronize()
    }

    /// Removes the values of the specified default key
    ///
    /// - Parameter keys: The keys whose values you want to remove
    func removeObjects(forKeys keys: Set<Key>) {
        keys.forEach { self.removeObject(forKey: $0) }
    }
}

// MARK: - Keys
extension ArchiveService {

    enum Key: String {
        case serviceDefaults = "ServiceDefaults"
    }
    
}

// MARK: - Models
extension ArchiveService {
    var servicesModels: [ServiceModel] {
        get {
            return self.models(type: ServiceModel.self, forKey: .serviceDefaults) ?? []
        }
        set {
            self.set(models: newValue, forKey: .serviceDefaults)
        }
    }
}
