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

struct ValidationDateTests {
    
    struct Minimum {
        @Test func validDate() {
            let dateString = "2020-02-20"
            let minimum = date(from: dateString)!
            let error = "Date should be greater than \(dateString)"
            @Validate(.min(minimum, message: error))
            var value = date(from: "2020-03-03")!
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidDate() {
            let dateString = "2018-08-28"
            let minimum = date(from: dateString)!
            let error = "Date should be greater than \(dateString)"
            @Validate(.min(minimum, message: error))
            var value = date(from: "2018-07-21")!
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidDate() {
            let dateString = "2010-10-11"
            let minimum = date(from: dateString)!
            let error = "Date should be greater than \(dateString)"
            @Validate(.min(minimum, message: error))
            var value = date(from: dateString)!
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidDate() {
            let dateString = "2004-12-01"
            let minimum = date(from: dateString)!
            let error = "Date should be greater than \(dateString)"
            @Validate(.min(minimum, message: error))
            var value = date(from: "2004-11-30")!
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Maximum {
        @Test func validDate() {
            let dateString = "1998-05-07"
            let maximum = date(from: dateString)!
            let error = "Date should be less than \(dateString)"
            @Validate(.max(maximum, message: error))
            var value = date(from: "1996-02-21")!
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidDate() {
            let dateString = "2028-04-18"
            let maximum = date(from: dateString)!
            let error = "Date should be less than \(dateString)"
            @Validate(.max(maximum, message: error))
            var value = date(from: "2030-10-17")!
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidDate() {
            let dateString = "2101-03-07"
            let maximum = date(from: dateString)!
            let error = "Date should be less than \(dateString)"
            @Validate(.max(maximum, message: error))
            var value = date(from: dateString)!
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidDate() {
            let dateString = "1995-06-09"
            let maximum = date(from: dateString)!
            let error = "Date should be less than \(dateString)"
            @Validate(.max(maximum, message: error))
            var value = date(from: "1995-06-10")!
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Range {
        @Test func validDate() {
            let dateMinString = "2001-01-01"
            let dateMaxString = "2010-12-31"
            let minimum = date(from: dateMinString)!
            let maximum = date(from: dateMaxString)!
            let range = minimum...maximum
            let error = "Date should be between \(dateMinString) and \(dateMaxString)"
            @Validate(.range(range, message: error))
            var value = date(from: "2005-05-05")!
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidDate() {
            let dateMinString = "2011-01-01"
            let dateMaxString = "2020-12-31"
            let minimum = date(from: dateMinString)!
            let maximum = date(from: dateMaxString)!
            let range = minimum...maximum
            let error = "Date should be between \(dateMinString) and \(dateMaxString)"
            @Validate(.range(range, message: error))
            var value = date(from: "2021-11-22")!
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func equalToLowerBound() {
            let dateMinString = "2011-01-01"
            let dateMaxString = "2020-12-31"
            let minimum = date(from: dateMinString)!
            let maximum = date(from: dateMaxString)!
            let range = minimum...maximum
            let error = "Date should be between \(dateMinString) and \(dateMaxString)"
            @Validate(.range(range, message: error))
            var value = date(from: dateMinString)!
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyLessThanRange() {
            let dateMinString = "2014-04-21"
            let dateMaxString = "2020-12-31"
            let minimum = date(from: dateMinString)!
            let maximum = date(from: dateMaxString)!
            let range = minimum...maximum
            let error = "Date should be between \(dateMinString) and \(dateMaxString)"
            @Validate(.range(range, message: error))
            var value = date(from: "2014-04-20")!
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func equalToUpperBound() {
            let dateMinString = "2011-01-01"
            let dateMaxString = "2020-12-31"
            let minimum = date(from: dateMinString)!
            let maximum = date(from: dateMaxString)!
            let range = minimum...maximum
            let error = "Date should be between \(dateMinString) and \(dateMaxString)"
            @Validate(.range(range, message: error))
            var value = date(from: dateMaxString)!
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func barelyGreaterThanRange() {
            let dateMinString = "2014-04-21"
            let dateMaxString = "2022-10-10"
            let minimum = date(from: dateMinString)!
            let maximum = date(from: dateMaxString)!
            let range = minimum...maximum
            let error = "Date should be between \(dateMinString) and \(dateMaxString)"
            @Validate(.range(range, message: error))
            var value = date(from: "2022-10-11")!
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
}
