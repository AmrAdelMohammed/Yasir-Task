//
//  DecodingService.swift
//  Yasir Task
//
//  Created by Amr Adel on 13/12/2024.
//

import Foundation

protocol DecodingService {
    typealias EncodingStrategy = JSONEncoder.KeyEncodingStrategy
    typealias DecodingStrategy = JSONDecoder.KeyDecodingStrategy
    var encoder: JSONEncoder { get }
    var encodingStrategy: EncodingStrategy { get }
    var decoder: JSONDecoder { get }
    var decodingStrategy: DecodingStrategy { get }
    func decode<T: Decodable>(_ data: Data, to type: T.Type) throws -> T
    func decodeReturningNilOnFailure<T: Decodable>(_ data: Data, to: T.Type) -> T?
    func encode<T: Encodable>(_ obj: T) throws -> Data
    func encodeReturningNilOnFailure<T: Encodable>(_ obj: T) -> Data?
}

class AppDecodingService: DecodingService {
    
    var encoder: JSONEncoder { self._encoder }
    var encodingStrategy: EncodingStrategy {
        self._encodingStrategy
    }
    var decoder: JSONDecoder { self._decoder }
    var decodingStrategy: DecodingStrategy {
        self._decodingStrategy
    }
    //
    private let _encodingStrategy: EncodingStrategy
    private let _decodingStrategy: DecodingStrategy
    private lazy var _encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = self.encodingStrategy
        return encoder
    }()
    private lazy var _decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = self.decodingStrategy
        return decoder
    }()
    
    init(encodingStrategy: EncodingStrategy = .useDefaultKeys,
         decodingStrategy: DecodingStrategy = .useDefaultKeys) {
        self._encodingStrategy = encodingStrategy
        self._decodingStrategy = decodingStrategy
    }
    
    func decode<T: Decodable>(_ data: Data, to type: T.Type) throws -> T {
        do {
            return try self.decoder.decode(type.self, from: data)
        } catch {
            debugPrint("❌ Failed to decode using given strategy and retrying with default decoding strategy, error: \(error) ❌")
            let decoderWithoutStrategy = JSONDecoder()
            return try decoderWithoutStrategy.decode(type.self, from: data)
        }
    }
    
    func decodeReturningNilOnFailure<T: Decodable>(_ data: Data, to type: T.Type) -> T? {
        do {
            return try self.decode(data, to: type)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    public func encode<T: Encodable>(_ obj: T) throws -> Data {
        return try encoder.encode(obj)
    }
    
    public func encodeReturningNilOnFailure<T: Encodable>(_ obj: T) -> Data? {
        do {
            return try encoder.encode(obj)
        } catch {
            print(error)
            return nil
        }
    }
    
    
}
