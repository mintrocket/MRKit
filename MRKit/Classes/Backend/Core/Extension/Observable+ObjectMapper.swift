//
//  Observable+ObjectMapper.swift
//  RedArmy
//
//  Created by Kirill Kunst on 24/01/2017.
//  Copyright © 2017 MintRocket LLC. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

public extension ObservableType where E == ResponseData {
    
    public func mapObject<T: BaseMappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(T.self))
        }
    }
    
    public func mapArray<T: BaseMappable>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self))
        }
    }
}


// MARK: - ImmutableMappable
public extension ObservableType where E == ResponseData {
    
    public func mapObject<T: ImmutableMappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(T.self))
        }
    }
    
    public func mapArray<T: ImmutableMappable>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self))
        }
    }
    
}
