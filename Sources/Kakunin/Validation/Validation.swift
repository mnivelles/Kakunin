//
//  Validation.swift
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

/// A generic value validator that pairs a predicate closure with one or more error messages.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct Validation<Value> {
    
    public typealias Predicate = (Value) -> Bool
    
    let predicate: Predicate
    
    let messages: [String]
    
    public init(message: any StringProtocol, predicate: @escaping Predicate) {
        self.predicate = predicate
        self.messages = [String(message)]
    }
    
    public init(messages: [any StringProtocol], predicate: @escaping Predicate) {
        self.predicate = predicate
        self.messages = messages.map { String($0) }
    }
    
    public init<WrappedValue>(message: any StringProtocol,
                              _ validation: Validation<WrappedValue>,
                              isNilValid: @autoclosure @escaping () -> Bool = false) where WrappedValue? == Value {
        self.init(message: message) { value in
            value.flatMap(validation.validate) ?? isNilValid()
        }
    }
}

public extension Validation {
    
    func validate(_ value: Value) -> Bool {
        self.predicate(value)
    }
}
