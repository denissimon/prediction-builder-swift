PredictionBuilder
=================

[![Swift](https://img.shields.io/badge/Swift-5-orange.svg?style=flat)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20Linux-lightgrey.svg)](https://developer.apple.com/swift/)

PredictionBuilder is a library for machine learning that builds predictions using a linear regression.

Installation
------------

#### Swift Package Manager

To install PredictionBuilder using [Swift Package Manager](https://swift.org/package-manager):

```txt
Xcode: File -> Add Packages
Enter Package URL: https://github.com/denissimon/prediction-builder-swift
```

#### CocoaPods

To install PredictionBuilder using [CocoaPods](https://cocoapods.org), add this line to your `Podfile`:

```ruby
pod 'PredictionBuilder', '~> 1.2'
```

#### Carthage

To install PredictionBuilder using [Carthage](https://github.com/Carthage/Carthage), add this line to your `Cartfile`:

```ruby
github "denissimon/prediction-builder-swift"
```

#### Manually

Copy `PredictionBuilder.swift` into your project.

Example
-------

```swift
import PredictionBuilder

let data: [[Double]] = [[1,20],[2,70],[2,45],[3,81],[5,73],[6,80],[7,110]]
let x: Double = 4.5

let prediction = PredictionBuilder()

prediction.set(x: x, data: data)

// What is the expected y value for a given x value?
do {
    let result = try prediction.build() // y = 76.65
} catch let msg {
    print(msg)
}
```

The returned instance has the following properties:

`result.lnModel` linear model that fits the data: "29.56362+10.46364x"

`result.cor` correlation coefficient: 0.8348

`result.x` given x value: 4.5

`result.y` predicted y value: 76.65

License
-------

Licensed under the [MIT License](https://github.com/denissimon/prediction-builder-swift/blob/master/LICENSE)
