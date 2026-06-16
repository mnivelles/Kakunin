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

import Testing
@testable import Kakunin

struct ValidationSequenceTests {
    
    struct ContainsAny {
        @Test func valid() {
            let array = [1, 3, 6, 8, 9]
            let error = "Must contain any \(array)"
            @Validate(.contains(any: array, message: error))
            var sequence = [1, 2, 3, 4, 5, 6, 7]
            
            let result = $sequence
            
            #expect(result.isValid)
        }
        
        @Test func invalid() {
            let array = [8, 9]
            let error = "Must contain any \(array)"
            @Validate(.contains(any: array, message: error))
            var sequence = [1, 2, 3, 4, 5, 6, 7]
            
            let result = $sequence
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct ContainsAll {
        @Test func valid() {
            let array = [1, 3, 6]
            let error = "Must contain all \(array)"
            @Validate(.contains(all: array, message: error))
            var sequence = [1, 2, 3, 4, 5, 6, 7]
            
            let result = $sequence
            
            #expect(result.isValid)
        }
        
        @Test func invalid() {
            let array = [4, 8, 9]
            let error = "Must contain all \(array)"
            @Validate(.contains(all: array, message: error))
            var sequence = [1, 2, 3, 4, 5, 6, 7]
            
            let result = $sequence
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct StartsWith {
        @Test func valid() {
            let start = ["L", "I", "V"]
            let error = "Must start with \(start)"
            @Validate(.starts(with: start, message: error))
            var sequence = ["L", "I", "V", "R", "E", "S"]
            
            let result = $sequence
            
            #expect(result.isValid)
        }
        
        @Test func invalid() {
            let start = ["H", "O"]
            let error = "Must start with \(start)"
            @Validate(.starts(with: start, message: error))
            var sequence = ["S", "U", "M", "A", "H", "O"]
            
            let result = $sequence
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct EndsWith {
        @Test func valid() {
            let end = ["R", "E", "S"]
            let error = "Must end with \(end)"
            @Validate(.ends(with: end, message: error))
            var sequence = ["L", "I", "V", "R", "E", "S"]
            
            let result = $sequence
            
            #expect(result.isValid)
        }
        
        @Test func invalid() {
            let end = ["M", "A"]
            let error = "Must end with \(end)"
            @Validate(.ends(with: end, message: error))
            var sequence = ["S", "U", "M", "A", "H", "O"]
            
            let result = $sequence
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
}
