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

struct ValidationComparableTests {
    
    struct GreaterThanOrEqual {
        @Test func validInt() {
            let number = 5
            let error = "Should be greater or equal to \(number)"
            @Validate(.greaterOrEqual(number, message: error))
            var value = 7
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func validIntWithMin() {
            let number = 5
            let error = "Should be greater or equal to \(number)"
            @Validate(.min(number, message: error))
            var value = 7
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidInt() {
            let number = 20
            let error = "Should be greater or equal to \(number)"
            @Validate(.greaterOrEqual(number, message: error))
            var value = 18
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidInt() {
            let number = 9
            let error = "Should be greater or equal to \(number)"
            @Validate(.greaterOrEqual(number, message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidInt() {
            let number = 6
            let error = "Should be greater or equal to \(number)"
            @Validate(.greaterOrEqual(number, message: error))
            var value = number - 1
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validDouble() {
            let number = 5.2
            let error = "Should be greater or equal to \(number)"
            @Validate(.greaterOrEqual(number, message: error))
            var value = 7.7
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func validDoubleWithMin() {
            let number = 5.2
            let error = "Should be greater or equal to \(number)"
            @Validate(.min(number, message: error))
            var value = 7.7
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidDouble() {
            let number = 20.5
            let error = "Should be greater or equal to \(number)"
            @Validate(.greaterOrEqual(number, message: error))
            var value = 18.8
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidDouble() {
            let number = 9.7
            let error = "Should be greater or equal to \(number)"
            @Validate(.greaterOrEqual(number, message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidDouble() {
            let number = 6.1
            let error = "Should be greater or equal to \(number)"
            @Validate(.greaterOrEqual(number, message: error))
            var value = number - 0.1
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct GreaterThan {
        @Test func validInt() {
            let number = 5
            let error = "Should be greater than \(number)"
            @Validate(.greater(number, message: error))
            var value = 7
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidInt() {
            let number = 20
            let error = "Should be greater than \(number)"
            @Validate(.greater(number, message: error))
            var value = 18
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidInt() {
            let number = 9
            let error = "Should be greater than \(number)"
            @Validate(.greater(number, message: error))
            var value = number + 1
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidInt() {
            let number = 6
            let error = "Should be greater than \(number)"
            @Validate(.greater(number, message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validDouble() {
            let number = 5.2
            let error = "Should be greater than \(number)"
            @Validate(.greater(number, message: error))
            var value = 7.7
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidDouble() {
            let number = 20.8
            let error = "Should be greater than \(number)"
            @Validate(.greater(number, message: error))
            var value = 18.9
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidDouble() {
            let number = 9.6
            let error = "Should be greater than \(number)"
            @Validate(.greater(number, message: error))
            var value = number + 0.05
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidDouble() {
            let number = 6.6
            let error = "Should be greater than \(number)"
            @Validate(.greater(number, message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct LessThanOrEqual {
        @Test func validInt() {
            let number = 8
            let error = "Should be less or equal to \(number)"
            @Validate(.lessOrEqual(number, message: error))
            var value = 2
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func validIntWithMax() {
            let number = 8
            let error = "Should be less or equal to \(number)"
            @Validate(.max(number, message: error))
            var value = 2
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidInt() {
            let number = 15
            let error = "Should be less or equal to \(number)"
            @Validate(.lessOrEqual(number, message: error))
            var value = 17
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidInt() {
            let number = 9
            let error = "Should be less or equal to \(number)"
            @Validate(.lessOrEqual(number, message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidInt() {
            let number = 6
            let error = "Should be less or equal to \(number)"
            @Validate(.lessOrEqual(number, message: error))
            var value = number + 1
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validDouble() {
            let number = 8.6
            let error = "Should be less or equal to \(number)"
            @Validate(.lessOrEqual(number, message: error))
            var value = 2.7
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func validDoubleWithMax() {
            let number = 8.6
            let error = "Should be less or equal to \(number)"
            @Validate(.max(number, message: error))
            var value = 2.7
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidDouble() {
            let number = 15.5
            let error = "Should be less or equal to \(number)"
            @Validate(.lessOrEqual(number, message: error))
            var value = 17.7
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidDouble() {
            let number = 9.1
            let error = "Should be less or equal to \(number)"
            @Validate(.lessOrEqual(number, message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidDouble() {
            let number = 6.6
            let error = "Should be less or equal to \(number)"
            @Validate(.lessOrEqual(number, message: error))
            var value = number + 0.02
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct LessThan {
        @Test func validInt() {
            let number = 8
            let error = "Should be less than \(number)"
            @Validate(.less(number, message: error))
            var value = 2
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidInt() {
            let number = 15
            let error = "Should be less than \(number)"
            @Validate(.less(number, message: error))
            var value = 17
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidInt() {
            let number = 9
            let error = "Should be less than \(number)"
            @Validate(.less(number, message: error))
            var value = number - 1
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidInt() {
            let number = 6
            let error = "Should be less than \(number)"
            @Validate(.less(number, message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validDouble() {
            let number = 8.8
            let error = "Should be less than \(number)"
            @Validate(.less(number, message: error))
            var value = 2.2
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidDouble() {
            let number = 15.15
            let error = "Should be less than \(number)"
            @Validate(.less(number, message: error))
            var value = 17.17
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidDouble() {
            let number = 9.9
            let error = "Should be less than \(number)"
            @Validate(.less(number, message: error))
            var value = number - 0.002
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidDouble() {
            let number = 6.6
            let error = "Should be less than \(number)"
            @Validate(.less(number, message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Range {
        @Test func validInt() {
            let range = 3...6
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = 5
            
            let result = $number
            
            #expect(result.isValid)
        }
        
        @Test func invalidInt() {
            let range = 7...27
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = 4
            
            let result = $number
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func equalToLowerBound() {
            let range = -3...7
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = range.lowerBound
            
            let result = $number
            
            #expect(result.isValid)
        }
        
        @Test func barelyLessThanRange() {
            let range = 7...27
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = range.lowerBound - 1
            
            let result = $number
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func equalToUpperBound() {
            let range = -11...(-9)
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = range.upperBound
            
            let result = $number
            
            #expect(result.isValid)
        }
        
        @Test func barelyGreaterThanRange() {
            let range = 0...22
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = range.upperBound + 1
            
            let result = $number
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validDouble() {
            let range = (3.3)...(6.6)
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = 5.5
            
            let result = $number
            
            #expect(result.isValid)
        }
        
        @Test func invalidDouble() {
            let range = (7.7)...(27.27)
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = 4
            
            let result = $number
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func doubleEqualToLowerBound() {
            let range = (-3.3)...(7.7)
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = range.lowerBound
            
            let result = $number
            
            #expect(result.isValid)
        }
        
        @Test func doubleBarelyLessThanRange() {
            let range = (7.7)...(27.27)
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = range.lowerBound - 0.0071
            
            let result = $number
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func doubleEqualToUpperBound() {
            let range = (-11.11)...(-9.9)
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = range.upperBound
            
            let result = $number
            
            #expect(result.isValid)
        }
        
        @Test func doubleBarelyGreaterThanRange() {
            let range = (0.0009)...(22.22)
            let error = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.range(range, message: error))
            var number = range.upperBound + 0.0011
            
            let result = $number
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
}
