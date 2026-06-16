# Getting Started with Kakunin

Use Property Wrappers to validate a form.

## Validate Properties

### Add a Validation

To validate a property, you use @``Validate`` attribute with a list of validations. Every validation has a `message` parameter.

```swift
@Validate(.min(16, message: "you must be at least 16 years old"))
var age: Int = 17
```

Most of the time, a non-`nil` value needs to be provided for the element being validated. That's why the default value of age is set to `17`.

### Add several Validations

You can add as many validations rules as you like. However, at least one is required.

#### Combine Validation rules with AND operator

Due to technical limitations, you cannot use `&&` to combine validation rules. Instead, you should use a comma-separated list of validation rules.

```swift
@Validate(.min(16, message: "you must be at least 16 years old"),
          .max(60, message: "you can't be older than 60 years old"))
var age: Int = 17
```

#### Combine Validation rules with OR operator

You can use `||` operator to combine several validation rules.

```swift
@Validate(.starts(with: "A", message: "must start with A")
          || .starts(with: "Z", message: "must start with Z")
          || .starts(with: "M", message: "must start with M"))
var name : String = "Aqua"
```

#### Negate Validation rule with NOT operator

You can use the `!` operator to invert a validation rule. The message should reflect the error of the negated validation rule.

```swift
@Validate(!.range(3...5, message: "you can't have 3 to 5 children"))
var numberOfChildren: Int = 7
```
#### Combine Validation rules with different operator

Use AND, OR and NOT operator to create complex validations.

```swift
@Validate(.starts(with: "9", message: "must start with 9")
          || .starts(with: "8", message: "must start with 8"),
          !.ends(with: "0", message: "must not end with 0"),
          .includes(only: .decimalDigits, message: "must contains only numbers"))
var frPostalCode = "89101"
```

### Custom Validation

For unsupported types or specific case validations, there is a special validation called ``Validation/custom(_:message:)``. It allows you to validate a property using a closure.

### List of Validation

You can find the full list of validation on the ``Validation`` page. They are listed here by type and protocol conformance.

#### BinaryInteger

- ``Validation/multiple(of:message:)``

#### Bool

- ``Validation/isTrue(message:)``
- ``Validation/isFalse(message:)``

#### Collection

- ``Validation/empty(message:)``
- ``Validation/nonempty(message:)``
- ``Validation/minCount(_:message:)-4ikga``
- ``Validation/maxCount(_:message:)-4ama2``
- ``Validation/count(_:message:)-5q9wh``
- ``Validation/countRange(_:message:)``


#### Comparable

- ``Validation/greaterOrEqual(_:message:)``
- ``Validation/min(_:message:)-55pca``
- ``Validation/greater(_:message:)``
- ``Validation/lessOrEqual(_:message:)``
- ``Validation/max(_:message:)-79nar``
- ``Validation/less(_:message:)``
- ``Validation/range(_:message:)-1w8xa``

#### Constant

- ``Validation/constant(_:message:)``

#### Custom (pass a closure to validate)

- ``Validation/custom(_:message:)``

#### Date

- ``Validation/min(_:message:)-c5gy``
- ``Validation/max(_:message:)-5mcob``
- ``Validation/range(_:message:)-2rwse``

#### Equatable

- ``Validation/equals(_:message:)``

#### KeyPath

- ``Validation/keyPath(_:message:)``
- ``Validation/keyPath(_:_:message:)``

#### Numeric & Comparable

- ``Validation/positive(message:)``
- ``Validation/nonnegative(message:)``
- ``Validation/negative(message:)``
- ``Validation/nonpositive(message:)``

#### Sequence

- ``Validation/contains(any:message:)``
- ``Validation/contains(all:message:)``
- ``Validation/starts(with:message:)``
- ``Validation/ends(with:message:)``

#### String

- ``Validation/required(message:)``
- ``Validation/regex(pattern:options:message:)``
- ``Validation/email(message:)``
- ``Validation/emoji(message:)``
- ``Validation/httpUrl(message:)``
- ``Validation/ip(version:message:)``
- ``Validation/dateTimeISO8601(options:message:)``
- ``Validation/hexColor(message:)``
- ``Validation/minCount(_:message:)-5q9l9``
- ``Validation/maxCount(_:message:)-8dy99``
- ``Validation/count(_:message:)-9dhki``
- ``Validation/contains(_:options:message:)``
- ``Validation/starts(with:options:message:)``
- ``Validation/ends(with:options:message:)``
- ``Validation/includes(only:message:)``

## Create a custom Validation

You can create new validations by extending ``Validation``. Here's an example.

```swift
import Foundation

public extension Validation where Value: Collection {

  static func countIsEven(message: String) -> Self {
    .init(message: message) { value in
      value.count.isMultiple(of: 2)
    }
  }
}
```

```swift
@Validate(.countIsEven(message: "must have an even count"))
var array: [Int] = [3, 5, 7, 8]
```

## Validation errors

To retrieve the status (`isValid`) and the errors list (`errors`), add a **`$`** before the validated variable's name.

```swift
@Validate(.min(11, message: "you must be at least 11 years old"),
          .max(60, message: "you can't be older than 60 years old"))
var age: Int = 10

// $age is a Validate.Result

print("is valid \($age.isValid)")

print("Errors: \($age.errors)")
```

## Example

```swift
import SwiftUI

fileprivate struct SceneState {
    @Validate(.required(message: "name is required"),
              .maxCount(20, message: "name must be less or equal 20 characters"))
    var name = ""
            
    @Validate(.min(16, message: "you must be at least 16 years old"),
              .max(60, message: "you can't be older than 60 years old"))
    var age: Int = 17
                    
    @Validate(.starts(with: "M", message: "must start with M")
              || .starts(with: "Z", message: "must start with Z"))
    var nameInitial : String = ""
                                
    @Validate(!.range(3...5, message: "you can't have 3 to 5 children"))
    var numberOfChildren: Int = 3
                                
    @Validate(.starts(with: "9", message: "must start with 9")
              || .starts(with: "8", message: "must start with 8"),
              !.ends(with: "0", message: "must not end with 0"),
              .includes(only: .decimalDigits, message: "must contains only numbers"))
    var frPostalCode = ""
                                        
    var isValid: Bool {
        $name.isValid
        && $age.isValid
        && $nameInitial.isValid
        && $numberOfChildren.isValid
        && $frPostalCode.isValid
    }
}

struct PersonScene: View {
    
    @State private var state = SceneState()
    
    var body: some View {
        Form {
            Section {
                TextField("Name...",
                            text: $state.name)
            } footer: {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(state.$name.errors, id: \.self) { error in
                        Text(error)
                        .foregroundStyle(.red)
                    }
                }
            }
            
            Section {
                Stepper("Age: \(state.age)", value: $state.age)
            } footer: {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(state.$age.errors, id: \.self) { error in
                        Text(error)
                        .foregroundStyle(.red)
                    }
                }
            }
            
            Section {
                TextField("Name initial",
                            text: $state.nameInitial)
            } footer: {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(state.$nameInitial.errors, id: \.self) { error in
                        Text(error)
                        .foregroundStyle(.red)
                    }
                }
            }
            
            Section {
                Stepper("Number of children: \(state.numberOfChildren)",
                        value: $state.numberOfChildren,
                        in: 0...20)
            } footer: {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(state.$numberOfChildren.errors, id: \.self) { error in
                        Text(error)
                        .foregroundStyle(.red)
                    }
                }
            }
            
            Section {
                TextField("FR Postalcode",
                            text: $state.frPostalCode)
            } footer: {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(state.$frPostalCode.errors, id: \.self) { error in
                        Text(error)
                        .foregroundStyle(.red)
                    }
                }
            }
            
            Button("Submit") {
                print("Form is valid")
            }
            .disabled(!state.isValid)
        }
    }
}

#Preview {
    PersonScene()
}

```
