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

struct ValidationOperatorTests {
    
    struct Not {
        @Test func validTest() {
            let multiple = 5
            let error = "Should not be multiple of \(multiple)"
            @Validate(!.multiple(of: multiple, message: error))
            var value = 17
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidTest() {
            let multiple = 2
            let error = "Should not be even"
            @Validate(!.multiple(of: multiple, message: error))
            var value = 54
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Or {
        @Test func validMrsOrDr() {
            let errorMrs = "Should start with Mrs"
            let errorDr = "Should start with Dr"
            @Validate(.starts(with: "Mrs", message: errorMrs)
                      || .starts(with: "Dr", message: errorDr))
            var value = "Mrs Smith"
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidMrsOrDr() {
            let errorMrs = "Should start with Mrs"
            let errorDr = "Should start with Dr"
            @Validate(.starts(with: "Mrs", message: errorMrs)
                      || .starts(with: "Dr", message: errorDr))
            var value = "Yamamoto-san"
            
            let result = $value
            let expectedFirstError = result.errors.first ?? "[invalid]"
            let expectedSecondError = result.errors[1]
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 2)
            #expect(errorMrs == expectedFirstError)
            #expect(errorDr == expectedSecondError)
        }
        
        @Test func invalidMrsAndValidDr() {
            let errorMrs = "Should start with Mrs"
            let errorDr = "Should start with Dr"
            @Validate(.starts(with: "Mrs", message: errorMrs)
                      || .starts(with: "Dr", message: errorDr))
            var value = "Dr Allen"
            
            let result = $value
            
            #expect(result.isValid)
        }
    }
    
    struct NotOr {
        @Test func validText() {
            let errorMrs = "Should not start with Mrs"
            let errorDr = "Should start with Dr"
            @Validate(!.starts(with: "Mrs", message: errorMrs)
                      || .starts(with: "Dr", message: errorDr))
            var value = "Dr Doe"
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidText() {
            let errorMr = "Should not start with Mr"
            let errorDr = "Should start with Dr"
            @Validate(!.starts(with: "Mr", message: errorMr)
                      || .starts(with: "Dr", message: errorDr))
            var value = "Mr Durand"
            
            let result = $value
            let expectedFirstError = result.errors.first ?? "[invalid]"
            let expectedSecondError = result.errors[1]
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 2)
            #expect(errorMr == expectedFirstError)
            #expect(errorDr == expectedSecondError)
        }
    }
    
    struct And {
        @Test func validText() {
            let errorMrs = "Should not start with Mrs"
            let errorII = "Should end with II"
            @Validate(.starts(with: "Mrs", message: errorMrs),
                      .ends(with: "II", message: errorII))
            var value = "Mrs Lucy II"
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidText() {
            let errorMrs = "Should not start with Mrs"
            let errorII = "Should end with II"
            @Validate(.starts(with: "Mrs", message: errorMrs),
                      .ends(with: "II", message: errorII))
            var value = "Mrs Lucy IV"
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(errorII == expectedError)
        }
        
        @Test func invalidMrsAndII() {
            let errorMrs = "Should not start with Mrs"
            let errorII = "Should end with II"
            @Validate(.starts(with: "Mrs", message: errorMrs),
                      .ends(with: "II", message: errorII))
            var value = "Mr Carl IV"
            
            let result = $value
            let expectedFirstError = result.errors.first ?? "[invalid]"
            let expectedSecondError = result.errors[1]
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 2)
            #expect(errorMrs == expectedFirstError)
            #expect(errorII == expectedSecondError)
        }
    }
}
