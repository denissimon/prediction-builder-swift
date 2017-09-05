PredictionBuilder
=================

PredictionBuilder is a library for machine learning that builds predictions using a linear regression.

Requirements
------------

Swift 3.0+

Installation
------------

#### CocoaPods

To install the library using [CocoaPods](https://cocoapods.org), add it to your `Podfile`:

```ruby
use_frameworks!
pod 'PredictionBuilder'
```

Then, run `pod install` (or `pod update`).

#### Swift Package Manager

To install the library using the [Swift Package Manager](https://swift.org/package-manager), add it to your `Package.swift` file:

```swift
dependencies: [
    .Package(url: "https://github.com/denissimon/prediction-builder-swift.git", majorVersion: 1)
]
```

#### Manual

Simply drag `PredictionBuilder.swift` into your project.

Example
-------

```swift
import PredictionBuilder

let data: [[Double]] = [[1,20],[2,70],[2,45],[3,81],[5,73],[6,80],[7,110]]
let x: Double = 4.5

// What is the expected y value for a given x value?
do {
    let prediction = PredictionBuilder(x: x, data: data)
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

Licensed under the [MIT license](https://github.com/denissimon/prediction-builder-swift/blob/master/LICENSE)
