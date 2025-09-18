PredictionBuilder
=================

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdenissimon%2Fprediction-builder-swift%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/denissimon/prediction-builder-swift) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdenissimon%2Fprediction-builder-swift%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/denissimon/prediction-builder-swift)

PredictionBuilder is a library for machine learning that builds predictions using a linear regression.

Installation
------------

#### Swift Package Manager

To install PredictionBuilder using [Swift Package Manager](https://swift.org/package-manager), add the following in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/denissimon/prediction-builder-swift.git", from: "1.2.2")
]
```

Or through Xcode:

```txt
File -> Add Package Dependencies
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
