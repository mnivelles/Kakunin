//
//  Validation+Sequence.swift
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

public extension Validation where Value: Sequence, Value.Element: Equatable {
    
    /// Validate if the value contains any of the specified elements.
    ///
    /// Validate that at least one element from the provided list exists in the sequence.
    ///
    /// - Parameters:
    ///   - elements: an array of elements to check against the value
    ///   - message: the error message
    static func contains(any elements: [Value.Element],
                         message: any StringProtocol) -> Self {
        .init(message: message) { value in
            elements.map(value.contains).contains(true)
        }
    }
    
    /// Validate if the value contains all of the specified elements.
    ///
    /// Validate that the sequence includes every element from the provided list. The validation will pass if all elements are found.
    ///
    /// - Parameters:
    ///   - elements: an array of elements to check against the value
    ///   - message: the error message
    static func contains(all elements: [Value.Element],
                         message: any StringProtocol) -> Self {
        .init(message: message) { value in
            elements.allSatisfy(value.contains)
        }
    }
    
    /// Validate if the value starts with the specified elements.
    /// - Parameters:
    ///   - elements: an array of elements to check against the beginning of the value
    ///   - message: the error message
    static func starts(with elements: [Value.Element],
                       message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value.starts(with: elements)
        }
    }
    
    /// Validate if the value ends with the specified elements.
    /// - Parameters:
    ///   - elements: an array of elements to check against the end of the value
    ///   - message: the error message
    static func ends(with elements: [Value.Element],
                     message: any StringProtocol) -> Self {
        .init(message: message) { value in
            let selfArray = Array(value)
            let suffixArray = Array(elements)
            
            guard suffixArray.count <= selfArray.count else {
                return false
            }
            
            return selfArray.suffix(suffixArray.count) == suffixArray
        }
    }
}
