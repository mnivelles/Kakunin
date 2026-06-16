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

struct ValidationCollectionTests {
    
    struct Empty {
        @Test func validArray() {
            let error = "Must be empty"
            @Validate(.empty(message: error))
            var array: [Character] = []
            
            let result = $array
            
            #expect(result.isValid)
        }
        
        @Test func invalidArray() {
            let error = "Must be empty"
            @Validate(.empty(message: error))
            var setCollection: Set<String> = ["D", "M", "G"]
            
            let result = $setCollection
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Nonempty {
        @Test func validArray() {
            let error = "Can't be empty"
            @Validate(.nonempty(message: error))
            var array: [Character] = ["D", "M", "G"]
            
            let result = $array
            
            #expect(result.isValid)
        }
        
        @Test func invalidArray() {
            let error = "Can't be empty"
            @Validate(.nonempty(message: error))
            var setCollection: Set<String> = []
            
            let result = $setCollection
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct MinimumCount {
        @Test func validStringArray() {
            let minimum = 6
            let error = "Length should be greater or equal to \(minimum)"
            @Validate(.minCount(minimum, message: error))
            var array = ["Aoi", "Aka", "Midori", "Kin", "Bleu", "Rouge", "Vert", "Doré"]
            
            let result = $array
            
            #expect(result.isValid)
        }
        
        @Test func invalidBoolArray() {
            let minimum = 3
            let error = "Length should be greater or equal to \(minimum)"
            @Validate(.minCount(minimum, message: error))
            var array = [true, true]
            
            let result = $array
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidIntArray() {
            let minimum = 5
            let error = "Length should be greater or equal to \(minimum)"
            @Validate(.minCount(minimum, message: error))
            var array = Array(Array(repeating: 3, count: minimum))
            
            let result = $array
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidIntSet() {
            let minimum = 4
            let error = "Length should be greater or equal to \(minimum)"
            @Validate(.minCount(minimum, message: error))
            var setCollection: Set<Int> = [7, 3, 1]
            
            let result = $setCollection
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct MaximumCount {
        @Test func validStringSet() {
            let maximum = 8
            let error = "Length should be less or equal to \(maximum)"
            @Validate(.maxCount(maximum, message: error))
            var setCollection: Set<String> = ["Tori", "Neko", "Inu", "Kitsune", "Usagi", "Tanuki"]
            
            let result = $setCollection
            
            #expect(result.isValid)
        }
        
        @Test func invalidIntSet() {
            let maximum = 4
            let error = "Length should be less or equal to \(maximum)"
            @Validate(.maxCount(maximum, message: error))
            var setCollection: Set<Int> = [7, 4, 1, 6, 55, 9]
            
            let result = $setCollection
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidDictionary() {
            let maximum = 6
            let error = "Length should be less or equal to \(maximum)"
            @Validate(.maxCount(maximum, message: error))
            var dict: [Int : String] = [
                7: "Nana",
                2: "Ni",
                9: "Ku",
                1: "Ichi",
                100: "Hyaku",
                8: "Hachi"
            ]
            
            let result = $dict
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidBoolArray() {
            let maximum = 3
            let error = "Length should be less or equal to \(maximum)"
            @Validate(.maxCount(maximum, message: error))
            var array = [true, true, true, false]
            
            let result = $array
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Count {
        @Test func validSet() {
            let count = 3
            let error = "Length should be \(count)"
            @Validate(.count(count, message: error))
            var setCollection: Set<String> = ["neko", "inu", "usagi"]
            
            let result = $setCollection
            
            #expect(result.isValid)
        }
        
        @Test func invalidArray() {
            let count = 5
            let error = "Length should be \(count)"
            @Validate(.count(count, message: error))
            var array = [1, 2, 3, 5]
            
            let result = $array
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct CountRange {
        @Test func validCharacterSet() {
            let range = 3...8
            let error = "Length should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.countRange(range, message: error))
            var setCollection: Set<Character> = [
                "Y",
                "O",
                "K",
                "A",
                "I"
            ]
            
            let result = $setCollection
            
            #expect(result.isValid)
        }
        
        @Test func invalidDoubleArray() {
            let range = 2...5
            let error = "Length should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.countRange(range, message: error))
            var array = [3.14]
            
            let result = $array
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func equalToLowerBound() {
            let range = 3...11
            let error = "Length should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.countRange(range, message: error))
            var array = [9.9, 2.01, -7.78]
            
            let result = $array
            
            #expect(result.isValid)
        }
        
        @Test func barelyLowerThanRange() {
            let range = 4...20
            let error = "Length should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.countRange(range, message: error))
            var array = [true, false, true]
            
            let result = $array
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func equalToUpperBound() {
            let range = 0...5
            let error = "Length should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.countRange(range, message: error))
            var array = ["A", "I", "U", "E", "O"]
            
            let result = $array
            
            #expect(result.isValid)
        }
        
        @Test func barelyGreaterThanRange() {
            let range = 2...4
            let error = "Length should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.countRange(range, message: error))
            var array = [8.2, 1.09, 3.56, 7.451, 3.63]
            
            let result = $array
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
}
