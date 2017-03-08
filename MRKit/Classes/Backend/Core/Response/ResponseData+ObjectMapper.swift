//
//  ResponseData+ObjectMapper.swift
//  RedArmy
//
//  Created by Kirill Kunst on 24/01/2017.
//  Copyright © 2017 MintRocket LLC. All rights reserved.
//

import Foundation
import ObjectMapper

public extension ResponseData {

    public func mapObject<T: BaseMappable>(_ type: T.Type) throws -> T {
        guard let object = Mapper<T>().map(JSONObject: self.data) else {
            throw AppError.unexpectedError(message: "Error while mapping object")
        }
        return object
    }

    public func mapArray<T: BaseMappable>(_ type: T.Type) throws -> [T] {
        guard let array = self.data as? [[String : Any]], let objects = Mapper<T>().mapArray(JSONArray: array) else {
            throw AppError.unexpectedError(message: "Error while mapping object")
        }
        return objects
    }
    
}


// MARK: - ImmutableMappable
public extension ResponseData {

    public func mapObject<T: ImmutableMappable>(_ type: T.Type) throws -> T {
        return try Mapper<T>().map(JSONObject: self.data)
    }
    

    public func mapArray<T: ImmutableMappable>(_ type: T.Type) throws -> [T] {
        guard let array = self.data as? [[String : Any]] else {
            throw AppError.unexpectedError(message: "Error while mapping object")
        }
        return try Mapper<T>().mapArray(JSONArray: array)
    }
    
}
