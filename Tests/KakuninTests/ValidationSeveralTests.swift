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

import Foundation

struct ValidationSeveralTests {
    
    struct Int {
        @Test func validMinWithMax() {
            let minimum = 8
            let maximum = 32
            let errorMin = "Should be greater or equal to \(minimum)"
            let errorMax = "Should be less or equal to \(maximum)"
            @Validate(.greaterOrEqual(minimum, message: errorMin), .lessOrEqual(maximum, message: errorMax))
            var number = 24
            
            let result = $number
            
            #expect(result.isValid)
        }
        
        @Test func invalidRangeWithMaxLength() {
            let range = 2...15
            let maximum = 16
            let errorRange = "Should be in \(range.lowerBound)...\(range.upperBound)"
            let errorMax = "Should be less or equal to \(maximum)"
            @Validate(.range(range, message: errorRange), .lessOrEqual(maximum, message: errorMax))
            var number = 20
            
            let result = $number
            let expectedFirstError = result.errors.first ?? "[invalid]"
            let expectedSecondError = result.errors[1]
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 2)
            #expect(errorRange == expectedFirstError)
            #expect(errorMax == expectedSecondError)
        }
        
        @Test func invalidMinLengthAndValidRange() {
            let minimum = 7
            let range = 4...14
            let errorMin = "Should be less or equal to \(minimum)"
            let errorRange = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.greaterOrEqual(minimum, message: errorMin), .range(range, message: errorRange))
            var number = 5
            
            let result = $number
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(errorMin == expectedError)
        }
    }
    
    struct Double {
        @Test func validMinWithMax() {
            let minimum = 8.8
            let maximum = 32.32
            let errorMin = "Should be greater or equal to \(minimum)"
            let errorMax = "Should be less or equal to \(maximum)"
            @Validate(.greaterOrEqual(minimum, message: errorMin), .lessOrEqual(maximum, message: errorMax))
            var number = 24.24
            
            let result = $number
            
            #expect(result.isValid)
        }
        
        @Test func invalidRangeWithMaxLength() {
            let range = (2.2)...(15.15)
            let maximum = 16.16
            let errorRange = "Should be in \(range.lowerBound)...\(range.upperBound)"
            let errorMax = "Should be less or equal to \(maximum)"
            @Validate(.range(range, message: errorRange), .lessOrEqual(maximum, message: errorMax))
            var number = 20.2
            
            let result = $number
            let expectedFirstError = result.errors.first ?? "[invalid]"
            let expectedSecondError = result.errors[1]
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 2)
            #expect(errorRange == expectedFirstError)
            #expect(errorMax == expectedSecondError)
        }
        
        @Test func invalidMinLengthAndValidRange() {
            let minimum = 7.7
            let range = (4.4)...(14.14)
            let errorMin = "Should be less or equal to \(minimum)"
            let errorRange = "Should be in \(range.lowerBound)...\(range.upperBound)"
            @Validate(.greaterOrEqual(minimum, message: errorMin), .range(range, message: errorRange))
            var number = 5.5
            
            let result = $number
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(errorMin == expectedError)
        }
    }
    
    struct String {
        @Test func validEmailWithMaxCount() {
            let maximum = 20
            let errorEmail = "Email is not valid"
            let errorMax = "Text can't be more than \(maximum) characters"
            @Validate(.email(message: errorEmail), .maxCount(maximum, message: errorMax))
            var text = "yakyuu@baseball.jp"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidEmailWithMaxCount() {
            let maximum = 12
            let errorEmail = "Email is not valid"
            let errorMax = "Text can't be more than \(maximum) characters"
            @Validate(.email(message: errorEmail), .maxCount(maximum, message: errorMax))
            var text = "no-reply@space."
            
            let result = $text
            let expectedFirstError = result.errors.first ?? "[invalid]"
            let expectedSecondError = result.errors[1]
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 2)
            #expect(errorEmail == expectedFirstError)
            #expect(errorMax == expectedSecondError)
        }
        
        @Test func invalidEmailAndValidMinCount() {
            let minimum = 6
            let errorEmail = "Email is not valid"
            let errorMax = "Text can't be less than \(minimum) characters"
            @Validate(.email(message: errorEmail), .minCount(minimum, message: errorMax))
            var text = "no-where@.tv"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(errorEmail == expectedError)
        }
    }
    
    struct Collection {
        @Test func validNonemptyWithMinimum() {
            let minimum = 2
            let errorNonempty = "Can't be empty"
            let errorMinimum = "Should be greater or equal to \(minimum)"
            @Validate(.nonempty(message: errorNonempty),
                      .minCount(minimum, message: errorMinimum))
            var array = ["Yin", "Yang"]
            
            let result = $array
            
            #expect(result.isValid)
        }
        
        @Test func invalidMinimumWithNonempty() {
            let minimum = 2
            let errorNonempty = "Can't be empty"
            let errorMinimum = "Should be greater or equal to \(minimum)"
            @Validate(.nonempty(message: errorNonempty),
                      .minCount(minimum, message: errorMinimum))
            var array = ["Chi"]
            
            let result = $array
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(errorMinimum == expectedError)
        }
        
        @Test func invalidMinimumAndNonempty() {
            let minimum = 2
            let errorNonempty = "Can't be empty"
            let errorMinimum = "Should be greater or equal to \(minimum)"
            @Validate(.nonempty(message: errorNonempty),
                      .minCount(minimum, message: errorMinimum))
            var dict: [UUID:String] = [:]
            
            let result = $dict
            let expectedFirstError = result.errors.first ?? "[invalid]"
            let expectedSecondError = result.errors[1]
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 2)
            #expect(errorNonempty == expectedFirstError)
            #expect(errorMinimum == expectedSecondError)
        }
    }
    
    struct Date {
        @Test func validCustomAndMinimum() {
            let dateCustomString = "2018-01-01"
            let dateMinimumString = "2018-02-01"
            let errorCustom = "Date must be after \(dateCustomString)"
            let errorMinimum = "Date must be after \(dateMinimumString)"
            @Validate(.custom({ $0 > date(from: dateCustomString)! }, message: errorCustom),
                      .min(date(from: dateMinimumString)!, message: errorMinimum))
            var value = date(from: "2018-03-01")!
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidCustomAndMinimum() {
            let dateCustomString = "2018-01-01"
            let dateMinimumString = "2018-02-01"
            let errorCustom = "Date must be after \(dateCustomString)"
            let errorMinimum = "Date must be after \(dateMinimumString)"
            @Validate(.custom({ $0 > date(from: dateCustomString)! }, message: errorCustom),
                      .min(date(from: dateMinimumString)!, message: errorMinimum))
            var value = date(from: "2017-12-01")!
            
            let result = $value
            let expectedFirstError = result.errors.first ?? "[invalid]"
            let expectedSecondError = result.errors[1]
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 2)
            #expect(errorCustom == expectedFirstError)
            #expect(errorMinimum == expectedSecondError)
        }
    }
}
