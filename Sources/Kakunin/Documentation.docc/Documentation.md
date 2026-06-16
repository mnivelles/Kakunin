# ``Kakunin``

Simplify property validation in Swift using powerful Property Wrappers

## Overview

Kakunin is a powerful and intuitive validation framework designed for SwiftUI developers. It provides the `@Validate` attribute, enabling easy validation of properties within a SwiftUI view. The framework supports various common types, including numbers, strings, booleans, dates, collections, and sequences. Additionally, it offers custom validation through closures, allowing you to handle specific cases or complex types.

For maximum extensibility, Kakunin also allows you to create your own validation rules by extending the ``Validation`` struct, offering flexibility tailored to your specific needs.

## Inspired by

[The Ultimate Guide to Validation Patterns in SwiftUI from AzamSharp](https://azamsharp.com/2024/12/18/the-ultimate-guide-to-validation-patterns-in-swiftui.html)


## Features

- **Easy to use:** Integrates seamlessly into SwiftUI views with minimal configuration.
- **Several built-in validations:** Offers a variety of pre-defined validations for common types like numbers, strings, dates and collections.
- **User-provided error messages:** Customize error messages to provide clear feedback to users.
- **Logical operators:** Combine multiple validation rules using logical operators like OR (`||`), and NOT (`!`).
- **Extendable:** Create custom validation rules by extending the ``Validation`` struct to meet your unique needs.

### Featured

@Links(visualStyle: detailedGrid) {
  - <doc:GettingStarted>
}

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
