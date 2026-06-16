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

struct ValidationBinaryIntegerTests {
    
    struct MultipleOf {
        static let validMultipleOf5List = [
            -5,
             15,
             1045,
             -35,
             0,
             10
        ]
        
        @Test(arguments: validMultipleOf5List)
        func validMultiplesOf5(number: Int) {
            let error = "\(number) is not multiple of 5"
            @Validate(.multiple(of: 5, message: error))
            var value = number
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        static let invalidMultipleOf5List = [
            -4,
             11,
             1044,
             -32,
             3,
             88
        ]
        
        @Test(arguments: invalidMultipleOf5List)
        func invalidMultiplesOf5(number: Int) {
            let error = "\(number) is not multiple of 5"
            @Validate(.multiple(of: 5, message: error))
            var value = number
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
}
