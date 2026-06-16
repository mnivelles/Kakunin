//
//  Validation+String.swift
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

import Foundation

public extension Validation where Value: StringProtocol {
    
    /// Validate if the string is not empty after trimming whitespace and newlines.
    /// - Parameter message: the error message
    static func required(message: any StringProtocol) -> Self {
        .init(message: message) { value in
            !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    /// Validate if the string matches a given regular expression.
    /// - Parameters:
    ///   - pattern: the regular expression pattern
    ///   - options: the *optional* regular expression options
    ///   - message: the error message
    static func regex(pattern: @autoclosure @escaping () -> String,
                      options: @autoclosure @escaping () -> NSRegularExpression.Options = .init(),
                      message: any StringProtocol) -> Self {
        .init(message: message) { value in
            guard let regularExpression = try? NSRegularExpression(pattern: pattern(), options: options()) else {
                return false
            }
            
            return regularExpression.firstMatch(in: "\(value)",
                                                range: .init(value.startIndex..., in: value)) != nil
        }
    }
    
    /// Validate if the string is a valid email address.
    /// - Parameter message: the error message
    static func email(message: any StringProtocol) -> Self {
        .init(message: message) { value in
            isEmail(value)
        }
    }
    
    /// Validate if the string contains exactly one emoji.
    /// - Parameter message: the error message
    static func emoji(message: any StringProtocol) -> Self {
        .init(message: message) { value in
            isEmoji(value)
        }
    }
    
    /// Validate if the string is a valid HTTP URL.
    /// - Parameter message: the error message
    static func httpUrl(message: any StringProtocol) -> Self {
        .init(message: message) { value in
            let urlRegex = #"^(https?)://[^\s/$.?#].[^\s]*$"#
            return value.range(of: urlRegex, options: .regularExpression) != nil
            && URL(string: "\(value)") != nil
        }
    }
    
    enum IpVersion {
        case v4, v6
    }
    
    /// Validate if the string is a valid IP address.
    /// - Parameters:
    ///   - version: the desired IP version (`v4` for IPv4, `v6` for IPv6, or `nil` to allow both)
    ///   - message: the error message
    static func ip(version: IpVersion? = nil,
                   message: any StringProtocol) -> Self {
        .init(message: message) { value in
            let string = "\(value)"
            if version == .v4 {
                return isValidIPv4(string)
            } else if version == .v6 {
                return isValidIPv6(string)
            } else {
                return isValidIPv4(string) || isValidIPv6(string)
            }
        }
    }
    
    /// Validate if the string is a valid ISO 8601 date-time string.
    /// - Parameters:
    ///   - options: the *optional* options for the `ISO8601DateFormatter` to customize the format
    ///   - message: the error message
    static func dateTimeISO8601(options: ISO8601DateFormatter.Options? = nil,
                                message: any StringProtocol) -> Self {
        .init(message: message) { value in
            isValidISO8601Date("\(value)", options: options)
        }
    }
    
    /// Validate if the string is a valid hex color code.
    /// - Parameter message: the error message
    static func hexColor(message: any StringProtocol) -> Self {
        .init(message: message) { value in
            isHexColor("\(value)")
        }
    }
    
    /// Validate if the string has a minimum number of characters.
    /// - Parameters:
    ///   - minimum: the minimum number of characters the string must have
    ///   - message: the error message
    static func minCount(_ minimum: Int,
                         message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value.count >= minimum
        }
    }
    
    /// Validate if the string has a maximum number of characters.
    /// - Parameters:
    ///   - maximum: the maximum number of characters the string can have
    ///   - message: the error message
    static func maxCount(_ maximum: Int,
                         message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value.count <= maximum
        }
    }
    
    /// Validate if the string has exactly the specified number of characters.
    /// - Parameters:
    ///   - number: the exact number of characters the string must have
    ///   - message: the error message
    static func count(_ number: Int,
                      message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value.count == number
        }
    }
    
    /// Validate if the string contains the specified text.
    /// - Parameters:
    ///   - text: the text to check for in the string
    ///   - options: the *optional* comparison options
    ///   - message: the error message
    static func contains(_ text: @autoclosure @escaping () -> Value,
                         options: @autoclosure @escaping () -> NSString.CompareOptions = .init(),
                         message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value.range(of: text(), options: options()) != nil
        }
    }
    
    /// Validate if the string starts with the specified prefix.
    /// - Parameters:
    ///   - prefix: the prefix to check for
    ///   - options: the *optional* comparison options
    ///   - message: the error message
    static func starts(with prefix: @autoclosure @escaping () -> Value,
                       options: @autoclosure @escaping () -> NSString.CompareOptions = .init(),
                       message: any StringProtocol) -> Self {
        .init(message: message) { value in
            var newOptions: NSString.CompareOptions = [.anchored]
            newOptions.insert(options())
            
            return value.range(of: prefix(), options: newOptions) != nil
        }
    }
    
    /// Validate if the string ends with the specified suffix.
    /// - Parameters:
    ///   - suffix: the suffix to check for
    ///   - options: the *optional* comparison options
    ///   - message: the error message
    static func ends(with suffix: @autoclosure @escaping () -> Value,
                     options: @autoclosure @escaping () -> NSString.CompareOptions = .init(),
                     message: any StringProtocol) -> Self {
        .init(message: message) { value in
            var newOptions: NSString.CompareOptions = [.anchored, .backwards]
            newOptions.insert(options())
            
            return value.range(of: suffix(), options: newOptions) != nil
        }
    }
    
    /// Validate if the string contains only characters from a given set.
    ///
    /// Validate that the string consists entirely of characters from the allowed set.
    ///
    /// - Parameters:
    ///   - allowed: a `CharacterSet` that contains the allowed characters
    ///   - message: the error message
    static func includes(only allowed: CharacterSet,
                         message: any StringProtocol) -> Self {
        .init(message: message) { value in
            value.rangeOfCharacter(from: allowed.inverted) == nil
        }
    }
}

fileprivate func isEmail(_ email: any StringProtocol) -> Bool {
    let regex = #"^(?!\.)(?!.*\.\.)([a-zA-Z0-9_'+\-\.]*)[a-zA-Z0-9_+-]@([a-zA-Z0-9][a-zA-Z0-9\-]*\.)+[a-zA-Z]{2,}$"#
    let test = NSPredicate(format: "SELF MATCHES %@", regex)
    if test.evaluate(with: email) {
        return true
    } else {
        return false
    }
}

fileprivate func isEmoji(_ text: any StringProtocol) -> Bool {
    guard text.count == 1,
          let scalar = text.unicodeScalars.first else {
        return false
    }
    
    return scalar.properties.isEmoji && (scalar.value > 0x238C || scalar.properties.isEmojiPresentation)
}

fileprivate func isValidIPv4(_ text: String) -> Bool {
    let components = text.split(separator: ".")
    
    guard components.count == 4 else {
        return false
    }
    
    return components.allSatisfy { part in
        if let number = Int(part), number >= 0 && number <= 255 {
            return true
        }
        return false
    }
}

fileprivate func isValidIPv6(_ text: String) -> Bool {
    let ipv6Regex = #"^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}(([0-9]{1,3}\.){3,3}[0-9]{1,3})|([0-9a-fA-F]{1,4}:){1,4}:(([0-9]{1,3}\.){3,3}[0-9]{1,3}))$"#
    return text.range(of: ipv6Regex, options: .regularExpression) != nil
}

fileprivate func isValidISO8601Date(_ text: String, options: ISO8601DateFormatter.Options? = nil) -> Bool {
    let formatter = ISO8601DateFormatter()
    
    if let options {
        formatter.formatOptions = options
    }
    
    return formatter.date(from: text) != nil
}

fileprivate func isHexColor(_ text: String) -> Bool {
    let hexColorRegex = "^#?([A-Fa-f0-9]{3}|[A-Fa-f0-9]{4}|[A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", hexColorRegex)
    return predicate.evaluate(with: text)
}
