PredictionBuilder
=================

PredictionBuilder is a library for machine learning that builds predictions using a linear regression.

Requirements
------------

This project requires [Swift 3.0 or higher](https://swift.org).

Example
-------

```swift
var data: [[Double]] = [[1,20],[2,70],[2,45],[3,81],[5,73],[6,80],[7,110]]
var x: Double = 4.5

// What is the expected y value with the given x value?
do {
    var prediction = try PredictionBuilder(x: x, data: data)
    var result = try prediction.build() // y = 76.65
} catch ArgumentError.error(let msg) {
    print(msg)
}
```

The returned struct has the following properties:

`result.ln_model` linear model that fits the data: "29.56362+10.46364x"

`result.cor` correlation coefficient: 0.8348

`result.x` given x value: 4.5

`result.y` predicted y value: 76.65

License
-------

Licensed under the [MIT license](https://github.com/denissimon/prediction-builder-swift/blob/master/LICENSE)
