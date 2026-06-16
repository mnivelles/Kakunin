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

struct ValidateCustomTests {
    
    struct Int {
        @Test func validInt() {
            let error = "Should be multiple of 4"
            @Validate(.custom({ $0.isMultiple(of: 4) }, message: error))
            var value = 64
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidInt() {
            let error = "Should be multiple of 4"
            @Validate(.custom({ $0.isMultiple(of: 4) }, message: error))
            var value = 55
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Double {
        @Test func validDouble() {
            let error = "Rounded double must be 7"
            @Validate(.custom({ $0.rounded() == 7 }, message: error))
            var value = 7.34
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidDouble() {
            let error = "Rounded double must be 7"
            @Validate(.custom({ $0.rounded() == 7 }, message: error))
            var value = 7.54
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)        }
    }
    
    struct Bool {
        @Test func validBool() {
            let error = "Must be false"
            @Validate(.custom({ $0 == false }, message: error))
            var value = false
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidBool() {
            let error = "Must be false"
            @Validate(.custom({ $0 == false }, message: error))
            var value = true
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct String {
        @Test func validString() {
            let error = "Should contains ra"
            @Validate(.custom({ $0.contains("ra") }, message: error))
            var value = "orange"
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidString() {
            let error = "Should contains ra"
            @Validate(.custom({ $0.contains("ra") }, message: error))
            var value = "pomme"
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Collection {
        @Test func validCollection() {
            let error = "Size must be even"
            @Validate(.custom({ $0.count.isMultiple(of: 2) }, message: error))
            var value = [22, 11, 33, 55, 0, 44]
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidCollection() {
            let error = "Size must be even"
            @Validate(.custom({ $0.count.isMultiple(of: 2) }, message: error))
            var value = ["A", "I", "U", "E", "O"]
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Date {
        @Test func validDate() {
            let dateString = "2018-01-01"
            let error = "Date must be before \(dateString)"
            @Validate(.custom({ $0 < date(from: dateString)! },
                              message: error))
            var value = date(from: "2017-01-01")!
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidDate() {
            let dateString = "2018-01-01"
            let error = "Date must be before \(dateString)"
            @Validate(.custom({ $0 < date(from: dateString)! },
                              message: error))
            var value = date(from: "2019-01-01")!
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct SeveralRules {
        @Test func validGeneric() {
            let error1 = "Must be positive"
            let error2 = "Must be multiple of 7"
            @Validate(.custom({ $0 > 0 }, message: error1),
                      .custom({ $0.isMultiple(of: 7) }, message: error2))
            var value = 21
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidPositiveWithMultipleOf5() {
            let error1 = "Must be positive"
            let error2 = "Must be multiple of 5"
            @Validate(.custom({ $0 > 0 }, message: error1),
                      .custom({ $0.isMultiple(of: 5) }, message: error2))
            var value = -5
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error1 == expectedError)
        }
        
        @Test func invalidPositiveAndMultipleOf7() {
            let error1 = "Must be positive"
            let error2 = "Must be multiple of 7"
            @Validate(.custom({ $0 > 0 }, message: error1),
                      .custom({ $0.isMultiple(of: 7) }, message: error2))
            var value = -5
            
            let result = $value
            let expectedError1 = result.errors.first ?? "[invalid]"
            let expectedError2 = result.errors[1]
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 2)
            #expect(error1 == expectedError1)
            #expect(error2 == expectedError2)
        }
    }
}
