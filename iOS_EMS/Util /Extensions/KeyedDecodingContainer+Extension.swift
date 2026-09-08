//
//  KeyedDecoder.swift
//  iOS_EMS
//
//  Created by MacMini on 13/02/2026.
//
import Foundation
extension KeyedDecodingContainer {
    func decodeSafe<T: Decodable>(
        _ type: T.Type,
        forKey key: Key,
        default defaultValue: T? = nil
    ) -> T? {
        do {
            return try decodeIfPresent(type, forKey: key) ?? defaultValue
        } catch {
            print("Failed to decode \(key): \(error)")
            return defaultValue
        }
    }
}
