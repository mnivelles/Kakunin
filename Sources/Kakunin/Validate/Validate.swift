//
//  Validate.swift
//
//  Copyright (c) 2026 Mathieu Nivelles (https://github.com/mnivelles)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the “Software”), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

/// A property wrapper type that validates a value against a set of rules and exposes the validation result through its projected value.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@propertyWrapper
public struct Validate<Value> {
    private var value: Value
    private let rules: [Validation<Value>]
    private(set) var result: Result = .init(isValid: true, errors: [])
    
    public struct Result {
        public let isValid: Bool
        public let errors: [String]
    }
    
    public var wrappedValue: Value {
        get { value }
        set {
            value = newValue
            validate()
        }
    }

    public var projectedValue: Result {
        result
    }
    
    public init(wrappedValue: Value, _ rules: Validation<Value>...) {
        self.value = wrappedValue
        self.rules = rules
        
        validate()
    }
    
    // MARK: - Validation Logic
    private mutating func validate() {
        result = .init(isValid: true, errors: [])
        var errors: [String] = []
        
        for rule in rules {
            if !rule.predicate(value) {
                errors.append(contentsOf: rule.messages)
            }
        }
        
        result = .init(isValid: errors.isEmpty,
                       errors: errors)
    }
}
