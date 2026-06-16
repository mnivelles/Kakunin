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

struct ValidationKeyPathTests {
    
    struct KeyPath {
        @Test func validKeyPath() {
            let size = 6
            let error = "Count should equal to \(size)"
            @Validate(.keyPath(\.count, .equals(size, message: ""), message: error))
            var value = "Nezumi"
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidKeyPath() {
            let size = 20
            let error = "Count should equal to \(size)"
            @Validate(.keyPath(\.count, .equals(size, message: ""), message: error))
            var value = "Kitsune"
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct KeyPathBool {
        @Test func validKeyPath() {
            let user = User()
            let error = "User must be blue"
            @Validate(.keyPath(\.isBlue, message: error))
            var value = user
            
            let result = $value
            
            #expect(result.isValid)
        }
        
        @Test func invalidKeyPath() {
            let user = User()
            let error = "User must be green"
            @Validate(.keyPath(\.isGreen, message: error))
            var value = user
            
            let result = $value
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct User {
        let isBlue = true
        let isGreen = false
    }
}
