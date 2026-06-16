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

struct ValidationStringTests {
    
    struct Required {
        @Test func validText() {
            let error = "Text is required"
            @Validate(.required(message: error))
            var text = "Tarte Tatin"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func emptyText() {
            let error = "Text is required"
            @Validate(.required(message: error))
            var text = ""
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func spacesText() {
            let error = "Text is required"
            @Validate(.required(message: error))
            var text = "  \n\n  \t \t"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Regex {
        private let emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        private let frPhoneRegex = "^(?:\\+33|0)([1-9])(?:\\d{2}){4}$"
        
        @Test func validEmail() {
            let error = "Email is not valid"
            @Validate(.regex(pattern: emailRegex, message: error))
            var text = "jean@durand.fr"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidEmail() {
            let error = "Email is not valid"
            @Validate(.regex(pattern: emailRegex, message: error))
            var text = "paul@dupont.f"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validFrPhone() {
            let error = "FR phone is valid"
            @Validate(.regex(pattern: frPhoneRegex, message: error))
            var text = "+33612345678"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidFrPhone() {
            let error = "FR phone is valid"
            @Validate(.regex(pattern: frPhoneRegex, message: error))
            var text = "512345678"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validTextWithOptions() {
            let pattern = "^[a-z]{3}"
            let error = "Should start with 3 letters A to Z"
            @Validate(.regex(pattern: pattern, options: .caseInsensitive, message: error))
            var text = "ZIP code"
            
            let result = $text
            
            #expect(result.isValid)
        }
    }
    
    struct Email {
        @Test func validEmail() {
            let error = "Email is not valid"
            @Validate(.email(message: error))
            var text = "john@doe.uk"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidEmail() {
            let error = "Email is not valid"
            @Validate(.email(message: error))
            var text = "nanashi@@ito.jp"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validLongTLD() {
            let error = "Email is not valid"
            @Validate(.email(message: error))
            var text = "nihongo-no-noto@japan.school"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        static let validEmailList = [
            "email@domain.com",
            "firstname.lastname@domain.com",
            "email@subdomain.domain.com",
            "firstname+lastname@domain.com",
            "1234567890@domain.com",
            "email@domain-one.com",
            "_______@domain.com",
            "email@domain.name",
            "email@domain.co.jp",
            "firstname-lastname@domain.com",
            "very.common@example.com",
            "disposable.style.email.with+symbol@example.com",
            "other.email-with-hyphen@example.com",
            "fully-qualified-domain@example.com",
            "user.name+tag+sorting@example.com",
            "x@example.com",
            "mojojojo@asdf.example.com",
            "example-indeed@strange-example.com",
            "example@s.example",
            "user-@example.org",
            "user@my-example.com",
            "a@b.cd",
            "work+user@mail.com",
            "tom@test.te-st.com",
            "something@subdomain.domain-with-hyphens.tld",
            "common'name@domain.com",
            "francois@etu.inp-n7.fr",
            "Kami-no-Tou@yoru.JA"
        ]
        
        @Test(arguments: validEmailList)
        func validEmails(email: String) {
            let error = "Email \"\(email)\" is not valid"
            @Validate(.email(message: error))
            var text = email
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        static let invalidEmailList = [
            "francois@@etu.inp-n7.fr",
            #"email"@domain.com"#,
            #""e asdf sadf ?<>ail"@domain.com"#,
            #"" "@example.org"#,
            #""john..doe"@example.org"#,
            #""very.(),:;<>[]".VERY."very@\ "very".unusual"@strange.example.com"#,
            "a,b@domain.com",
            "email@123.123.123.123",
            "email@[123.123.123.123]",
            "postmaster@123.123.123.123",
            "user@[68.185.127.196]",
            "ipv4@[85.129.96.247]",
            "valid@[79.208.229.53]",
            "valid@[255.255.255.255]",
            "valid@[255.0.55.2]",
            "hgrebert0@[IPv6:4dc8:ac7:ce79:8878:1290:6098:5c50:1f25]",
            "bshapiro4@[IPv6:3669:c709:e981:4884:59a3:75d1:166b:9ae]",
            "jsmith@[IPv6:2001:db8::1]",
            "postmaster@[IPv6:2001:0db8:85a3:0000:0000:8a2e:0370:7334]",
            "postmaster@[IPv6:2001:0db8:85a3:0000:0000:8a2e:0370:192.168.1.1]",
            "plainaddress",
            "#@%^%#$@#$@#.com",
            "@domain.com",
            "Joe Smith &lt;email@domain.com&gt;",
            "email.domain.com",
            "email@domain@domain.com",
            ".email@domain.com",
            "email.@domain.com",
            "email..email@domain.com",
            "あいうえお@domain.com",
            "email@domain.com (Joe Smith)",
            "email@domain",
            "email@-domain.com",
            "email@111.222.333.44444",
            "email@domain..com",
            "Abc.example.com",
            "A@b@c@example.com",
            "colin..hacks@domain.com",
            #"a"b(c)d,e:f;g<h>i[j\k]l@example.com"#,
            #"just"not"right@example.com"#,
            #"this is"not\allowed@example.com"#,
            #"this\ still\"not\\allowed@example.com"#,
            "i_like_underscore@but_its_not_allowed_in_this_part.example.com",
            "QA[icon]CHOCOLATE[icon]@test.com",
            "invalid@-start.com",
            "invalid@end.com-",
            "a.b@c.d",
            "invalid@[1.1.1.-1]",
            "invalid@[68.185.127.196.55]",
            "temp@[192.168.1]",
            "temp@[9.18.122.]",
            "double..point@test.com",
            "asdad@test..com",
            "asdad@hghg...sd...au",
            "asdad@hghg........au",
            "invalid@[256.2.2.48]",
            "invalid@[999.465.265.1]",
            "jkibbey4@[IPv6:82c4:19a8::70a9:2aac:557::ea69:d985:28d]",
            "mlivesay3@[9952:143f:b4df:2179:49a1:5e82:b92e:6b6]",
            "gbacher0@[IPv6:bc37:4d3f:5048:2e26:37cc:248e:df8e:2f7f:af]",
            "invalid@[IPv6:5348:4ed3:5d38:67fb:e9b:acd2:c13:192.168.256.1]",
            "test@.com",
            "aaaaaaaaaaaaaaalongemailthatcausesregexDoSvulnerability@test.c"
        ]
        
        @Test(arguments: invalidEmailList)
        func invalidEmails(email: String) {
            let error = "Email \"\(email)\" is not valid"
            @Validate(.email(message: error))
            var text = email
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Emoji {
        @Test func validEmoji() {
            let error = "Text is not an emoji"
            @Validate(.emoji(message: error))
            var text = "⚽️"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidEmoji() {
            let error = "Text is not an emoji"
            @Validate(.emoji(message: error))
            var text = "O"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        static let validEmojiList = [
            "👋",
            "🍺",
            "👩‍🚀",
            "🫡",
            "👦🏽",
            "💚",
            "🐛",
            "🗝",
            "🐏",
            "🍡",
            "🎦",
            "😀",
            "😁",
            "😂"
        ]
        
        @Test(arguments: validEmojiList)
        func validEmojis(emoji: String) {
            let error = "Text is not an emoji"
            @Validate(.emoji(message: error))
            var text = emoji
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        static let invalidEmojiList = [
            ":-)",
            "😀 is an emoji",
            "😀stuff",
            "😀😀"
        ]
        
        @Test(arguments: invalidEmojiList)
        func invalidEmojis(emoji: String) {
            let error = "Text is not an emoji"
            @Validate(.emoji(message: error))
            var text = emoji
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct HttpUrl {
        @Test func validURL() {
            let error = "URL is not valid"
            @Validate(.httpUrl(message: error))
            var text = "https://apple.com/fr"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidURL() {
            let error = "URL is not valid"
            @Validate(.httpUrl(message: error))
            var text = "ringo°"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        static let validUrlList = [
            "http://apple.com",
            "https://apple.com/asdf?asdf=ljk3lk4&asdf=234#asdf"
        ]
        
        @Test(arguments: validUrlList)
        func validUrls(url: String) {
            let error = "URL is not valid"
            @Validate(.httpUrl(message: error))
            var text = url
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        static let invalidUrlList = [
            "asdf",
            "https:/",
            "asdfj@lkjsdf.com"
        ]
        
        @Test(arguments: invalidUrlList)
        func invalidUrls(url: String) {
            let error = "URL is not valid"
            @Validate(.httpUrl(message: error))
            var text = url
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct IP {
        @Test func validIPv4() {
            let error = "IP v4 is not valid"
            @Validate(.ip(version: .v4, message: error))
            var text = "255.255.255.255"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidIPv4() {
            let error = "IP v4 is not valid"
            @Validate(.ip(version: .v4, message: error))
            var text = "255.F.255.255"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validIPv6() {
            let error = "IP v6 is not valid"
            @Validate(.ip(version: .v6, message: error))
            var text = "2001:0db8:0000:0000:0000:8a2e:0370:7334"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidIPv6() {
            let error = "IP v6 is not valid"
            @Validate(.ip(version: .v6, message: error))
            var text = "2001:0db8:0000:0000,0000:8a2e:0370:7334"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validIP_v4() {
            let error = "IP is not valid"
            @Validate(.ip(message: error))
            var text = "192.1.168.0"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidIP_v4() {
            let error = "IP is not valid"
            @Validate(.ip(message: error))
            var text = "192.I.168.0"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validIP_v6() {
            let error = "IP is not valid"
            @Validate(.ip(message: error))
            var text = "2001:0db8:0000:0000:0000:8a2e:0370:7334"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidIP_v6() {
            let error = "IP is not valid"
            @Validate(.ip(message: error))
            var text = "2001:0db8:0000:0000://0000:8a2e:0370:7334"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        static let validIpList = [
            "1e5e:e6c8:daac:514b:114b:e360:d8c0:682c",
            "9d4:c956:420f:5788:4339:9b3b:2418:75c3",
            "474f:4c83::4e40:a47:ff95:0cda",
            "d329:0:25b4:db47:a9d1:0:4926:0000",
            "e48:10fb:1499:3e28:e4b6:dea5:4692:912c",
            "114.71.82.94",
            "0.0.0.0",
            "37.85.236.115",
            "2001:4888:50:ff00:500:d::",
            "2001:4888:50:ff00:0500:000d:000:0000",
            "2001:4888:50:ff00:0500:000d:0000:0000"
        ]
        
        @Test(arguments: validIpList)
        func validIps(ip: String) {
            let error = "IP \"\(ip)\" is not valid"
            @Validate(.ip(message: error))
            var text = ip
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        static let invalidIpList = [
            "d329:1be4:25b4:db47:a9d1:dc71:4926:992c:14af",
            "d5e7:7214:2b78::3906:85e6:53cc:709:32ba",
            "8f69::c757:395e:976e::3441",
            "54cb::473f:d516:0.255.256.22",
            "54cb::473f:d516:192.168.1",
            "256.0.4.4",
            "-1.0.555.4",
            "0.0.0.0.0",
            "1.1.1"
        ]
        
        @Test(arguments: invalidIpList)
        func invalidIps(ip: String) {
            let error = "IP \"\(ip)\" is not valid"
            @Validate(.ip(message: error))
            var text = ip
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct DateTimeISO8601 {
        @Test func validDate() {
            let error = "Date is not a valid ISO8601"
            @Validate(.dateTimeISO8601(message: error))
            var text = "2024-12-01T10:15:10Z"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidDate() {
            let error = "Date is not a valid ISO8601"
            @Validate(.dateTimeISO8601(message: error))
            var text = "2024-12-O1"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func valid29februaryWithOptions() {
            let error = "Date is not a valid ISO8601"
            @Validate(.dateTimeISO8601(options: [.withFullDate], message: error))
            var text = "2024-02-29"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        static let validDateList = [
            "2024-12-30T15:30:00Z",
            "2024-12-30T15:30:00+01:00",
            "2024-12-30T15:30:00-05:00",
            "2024-12-30T23:45:00+00:00",
            "2024-12-30T23:45:00+01:00",
            "2024-12-30T23:45:00-08:00"
        ]
        
        @Test(arguments: validDateList)
        func validDates(date: String) {
            let error = "Date \"\(date)\" is not a valid ISO8601"
            @Validate(.dateTimeISO8601(message: error))
            var text = date
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        static let validSpecialDateList = [
            "2024-02-29",
            "2023-01-01",
            "2024-12-30T15:30:00.123Z",
            "2024-12-30T15:30:00.123456Z",
            "2024-12-30T15:30:00.123+02:00",
            "20241230",
            "2024-W01",
            "2024-W01-1",
            "2024-W52-7",
            "2024-001",
            "2024-365",
            "2023-365"
        ]
        
        @Test(arguments: validSpecialDateList)
        func validSpecialDatesWithOptionsReset(date: String) {
            let error = "Date \"\(date)\" is not a valid ISO8601"
            @Validate(.dateTimeISO8601(options: [], message: error))
            var text = date
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        static let invalidDateWithDefaultOptionsList = [
            "2024-02-29",
            "2023-01-01",
            "2024-12-30T15:30:00.123Z",
            "2024-12-30T15:30:00.123456Z",
            "2024-12-30T15:30:00.123+02:00",
            "20241230",
            "2024-W01",
            "2024-W01-1",
            "2024-W52-7",
            "2024-001",
            "2024-365",
            "2023-365"
        ]
        
        @Test(arguments: invalidDateWithDefaultOptionsList)
        func invalidDatesWithDefaultOptions(date: String) {
            let error = "Date is not a valid ISO8601"
            @Validate(.dateTimeISO8601(message: error))
            var text = date
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct HexColor {
        @Test func validColor() {
            let error = "Color is not a valid hex color"
            @Validate(.hexColor(message: error))
            var text = "#FF0000"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidColor() {
            let error = "Color is not a valid hex color"
            @Validate(.hexColor(message: error))
            var text = "#00FFF00"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        static let validHexColorList = [
            "#ff0000ff",
            "#FF0034",
            "#CCCCCC",
            "0f38",
            "fff",
            "#f00"
        ]
        
        @Test(arguments: validHexColorList)
        func validColors(color: String) {
            let error = "Color \"\(color)\" is not a valid hex color"
            @Validate(.hexColor(message: error))
            var text = color
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        static let invalidHexColorList = [
            "#ff",
            "fff0a",
            "#ff12FG"
        ]
        
        @Test(arguments: invalidHexColorList)
        func invalidColors(color: String) {
            let error = "Color \"\(color)\" is not a valid hex color"
            @Validate(.hexColor(message: error))
            var text = color
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct MinimumCount {
        @Test func validText() {
            let minimum = 7
            let error = "Text can't be less than \(minimum) characters"
            @Validate(.minCount(minimum, message: error))
            var text = "okonomiyaki"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidText() {
            let minimum = 7
            let error = "Text can't be less than \(minimum) characters"
            @Validate(.minCount(minimum, message: error))
            var text = "katsu"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidText() {
            let minimum = 7
            let error = "Text can't be less than \(minimum) characters"
            @Validate(.minCount(minimum, message: error))
            var text = Array(Array(repeating: "A", count: minimum)).joined()
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidText() {
            let minimum = 7
            let error = "Text can't be less than \(minimum) characters"
            @Validate(.minCount(minimum, message: error))
            var text = Array(Array(repeating: "I", count: minimum - 1)).joined()
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct MaximumCount {
        @Test func validText() {
            let maximum = 10
            let error = "Text can't be more than \(maximum) characters"
            @Validate(.maxCount(maximum, message: error))
            var text = "takoyaki"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidText() {
            let maximum = 16
            let error = "Text can't be more than \(maximum) characters"
            @Validate(.maxCount(maximum, message: error))
            var text = "daifuku aux fraises"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func barelyValidText() {
            let maximum = 16
            let error = "Text can't be more than \(maximum) characters"
            @Validate(.maxCount(maximum, message: error))
            var text = Array(Array(repeating: "O", count: maximum)).joined()
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func barelyInvalidText() {
            let maximum = 16
            let error = "Text can't be more than \(maximum) characters"
            @Validate(.maxCount(maximum, message: error))
            var text = Array(Array(repeating: "S", count: maximum + 1)).joined()
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Count {
        @Test func validText() {
            let count = 8
            let error = "Text shoud have \(count) characters"
            @Validate(.count(count, message: error))
            var text = "yakitori"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidText() {
            let count = 9
            let error = "Text shoud have \(count) characters"
            @Validate(.count(count, message: error))
            var text = "tonkatsu"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
    
    struct Contains {
        @Test func validText() {
            let included = "wari"
            let error = "Text must include \"\(included)\""
            @Validate(.contains(included, message: error))
            var text = "owarimono"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidText() {
            let included = "niwa"
            let error = "Text must include \"\(included)\""
            @Validate(.contains(included, message: error))
            var text = "hi no hana"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validTextWithCaseInsensitive() {
            let included = "MOD"
            let error = "Text must include \"\(included)\""
            @Validate(.contains(included, options: .caseInsensitive, message: error))
            var text = "tomodachi"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func validTextWithDiacriticInsensitive() {
            let included = "cafe"
            let error = "Text must include \"\(included)\""
            @Validate(.contains(included, options: .diacriticInsensitive, message: error))
            var text = "café au lait"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func validTextWithDiacriticAndCaseInsensitive() {
            let included = "FETE"
            let error = "Text must include \"\(included)\""
            @Validate(.contains(included, options: [.diacriticInsensitive, .caseInsensitive], message: error))
            var text = "Fête Foraine"
            
            let result = $text
            
            #expect(result.isValid)
        }
    }
    
    struct StartsWith {
        @Test func validText() {
            let start = "tsu"
            let error = "Text must start with \"\(start)\""
            @Validate(.starts(with: start, message: error))
            var text = "tsubaki"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidText() {
            let start = "chi"
            let error = "Text must start with \"\(start)\""
            @Validate(.starts(with: start, message: error))
            var text = "shikabane"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validTextWithCaseInsensitive() {
            let start = "JITEn"
            let error = "Text must start with \"\(start)\""
            @Validate(.starts(with: start, options: .caseInsensitive, message: error))
            var text = "Jitensha"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func validTextWithCaseAndDiacriticInsensitive() {
            let start = "mais"
            let error = "Text must start with \"\(start)\""
            @Validate(.starts(with: start, options: [.caseInsensitive, .diacriticInsensitive], message: error))
            var text = "Maïs jaune"
            
            let result = $text
            
            #expect(result.isValid)
        }
    }
    
    struct EndsWith {
        @Test func validText() {
            let end = "iro"
            let error = "Text must end with \"\(end)\""
            @Validate(.ends(with: end, message: error))
            var text = "kin'iro"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidText() {
            let end = "yo"
            let error = "Text must end with \"\(end)\""
            @Validate(.ends(with: end, message: error))
            var text = "tamago"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
        
        @Test func validTextWithDiacriticInsensitive() {
            let end = "ça"
            let error = "Text must end with \"\(end)\""
            @Validate(.ends(with: end, options: .diacriticInsensitive, message: error))
            var text = "Mange ça et ca"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func validTextWithCaseAndDiacriticInsensitive() {
            let end = "FaCoN"
            let error = "Text must end with \"\(end)\""
            @Validate(.ends(with: end, options: [.diacriticInsensitive, .caseInsensitive], message: error))
            var text = "De toute façon"
            
            let result = $text
            
            #expect(result.isValid)
        }
    }
    
    struct IncludesOnly {
        @Test func validText() {
            let characterSet = CharacterSet.alphanumerics
            let error = "Text must contains only alphanumeric characters"
            @Validate(.includes(only: characterSet, message: error))
            var text = "les3chaussures"
            
            let result = $text
            
            #expect(result.isValid)
        }
        
        @Test func invalidText() {
            let characterSet = CharacterSet.uppercaseLetters
            let error = "Text must contains only uppercase letters"
            @Validate(.includes(only: characterSet, message: error))
            var text = "OneOkRock"
            
            let result = $text
            let expectedError = result.errors.first ?? "[invalid]"
            
            #expect(result.isValid == false)
            #expect(result.errors.count == 1)
            #expect(error == expectedError)
        }
    }
}
