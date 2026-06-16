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

struct ValidationNumericComparableTests {
    
    struct Positive {
        static let validIntList = [
            7,
            2,
            1,
            100
        ]
        
        @Test(arguments: validIntList)
        func validInts(number: Int) {
            let error = "\(number) should be positive"
            @Validate(.positive(message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        static let invalidIntList = [
            -17,
             0,
             -1,
             -6
        ]
        
        @Test(arguments: invalidIntList)
        func invalidInts(number: Int) {
            let error = "\(number) should be positive"
            @Validate(.positive(message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        static let validDoubleList = [
            7.1,
            2.21,
            1.001,
            100.65
        ]
        
        @Test(arguments: validDoubleList)
        func validDoubles(number: Double) {
            let error = "\(number) should be positive"
            @Validate(.positive(message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        static let invalidDoubleList = [
            -17.11,
             0,
             -0.0021,
             -1.42,
             -6.68
        ]
        
        @Test(arguments: invalidDoubleList)
        func invalidDoubles(number: Double) {
            let error = "\(number) should be positive"
            @Validate(.positive(message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Nonnegative {
        static let validIntList = [
            7,
            2,
            1,
            100,
            0
        ]
        
        @Test(arguments: validIntList)
        func validInts(number: Int) {
            let error = "\(number) should be nonnegative"
            @Validate(.nonnegative(message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        static let invalidIntList = [
            -17,
             -2,
             -1,
             -6
        ]
        
        @Test(arguments: invalidIntList)
        func invalidInts(number: Int) {
            let error = "\(number) should be nonnegative"
            @Validate(.nonnegative(message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        static let validDoubleList = [
            7.22,
            2.77,
            1.1,
            100.5,
            0,
            0.00012
        ]
        
        @Test(arguments: validDoubleList)
        func validDoubles(number: Double) {
            let error = "\(number) should be nonnegative"
            @Validate(.nonnegative(message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        static let invalidDoubleList = [
            -17.11,
             -2.7543,
             -1.4,
             -6.5,
             -0.001
        ]
        
        @Test(arguments: invalidDoubleList)
        func invalidDoubles(number: Double) {
            let error = "\(number) should be nonnegative"
            @Validate(.nonnegative(message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Negative {
        static let validIntList = [
            -7,
             -2,
             -1,
             -100
        ]
        
        @Test(arguments: validIntList)
        func validInts(number: Int) {
            let error = "\(number) should be negative"
            @Validate(.negative(message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        static let invalidIntList = [
            17,
            0,
            1,
            6
        ]
        
        @Test(arguments: invalidIntList)
        func invalidInts(number: Int) {
            let error = "\(number) should be negative"
            @Validate(.negative(message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        static let validDoubleList = [
            -7.64,
             -2.26,
             -1.12,
             -100.35,
             -0.0001
        ]
        
        @Test(arguments: validDoubleList)
        func validDoubles(number: Double) {
            let error = "\(number) should be negative"
            @Validate(.negative(message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        static let invalidDoubleList = [
            17.44,
            0,
            0.0002,
            1.71,
            6.95
        ]
        
        @Test(arguments: invalidDoubleList)
        func invalidDoubles(number: Double) {
            let error = "\(number) should be negative"
            @Validate(.negative(message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Nonpositive {
        static let validIntList = [
            -7,
             -2,
             -1,
             -100,
             0
        ]
        
        @Test(arguments: validIntList)
        func validInts(number: Int) {
            let error = "\(number) should be nonpositive"
            @Validate(.nonpositive(message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        static let invalidIntList = [
            17,
            2,
            1,
            6
        ]
        
        @Test(arguments: invalidIntList)
        func invalidInts(number: Int) {
            let error = "\(number) should be nonpositive"
            @Validate(.nonpositive(message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        static let validDoubleList = [
            -7.91,
             -2.255,
             -1.11,
             -100.23,
             0,
             -0.0001
        ]
        
        @Test(arguments: validDoubleList)
        func validDoubles(number: Double) {
            let error = "\(number) should be nonpositive"
            @Validate(.nonpositive(message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        static let invalidDoubleList = [
            17.65,
            2.101,
            1.01922,
            6.2,
            0.001
        ]
        
        @Test(arguments: invalidDoubleList)
        func invalidDoubles(number: Double) {
            let error = "\(number) should be nonpositive"
            @Validate(.nonpositive(message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
}
