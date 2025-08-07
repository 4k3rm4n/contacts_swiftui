//
//  UserDefaults.swift
//  contacts
//
//  Created by Bogdan on 10.06.2025.
//

import Combine
import Foundation

@propertyWrapper
class UserDefault<Value: Codable> {

    private let key: String
    private let defaultValue: Value
    private let container: UserDefaults

    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()

    private lazy var publisher: CurrentValueSubject<Value, Never> = {
        .init(wrappedValue)
    }()

    var wrappedValue: Value {
        get {
            if let value = container.value(forKey: key) as? Value {
                return value
            } else {
                return container.data(forKey: key).flatMap { try? decoder.decode(Value.self, from: $0) } ?? defaultValue
            }
        }
        set {
            switch newValue {
            case let optional as AnyOptional where optional.isNil:
                container.removeObject(forKey: key)
            case is Int, is Bool, is Float, is Double, is String, is URL:
                container.set(newValue, forKey: key)
            default:
                let data = try? encoder.encode(newValue)
                container.set(data, forKey: key)
            }
            container.synchronize()
            publisher.value = newValue
        }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        publisher.eraseToAnyPublisher()
    }

    init(key: String, defaultValue: Value, container: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
    }

}

public protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

extension UserDefault where Value: ExpressibleByNilLiteral {

    convenience init(key: String, _ container: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, container: container)
    }

}
