//
// PredictionBuilder.swift
//
// PredictionBuilder - A library for machine learning that builds predictions using a linear regression.
//
// Copyright (c) 2016-2017 Denis Simon <denis.v.simon@gmail.com>
//
// Licensed under MIT ( https://github.com/denissimon/prediction-builder-swift/blob/master/LICENSE )
//

import Foundation

public enum Error: ErrorType {
    case ArgumentError(msg: String)
}

public class PredictionBuilder {
    
    private var x: Double
    private var count: Int
    private var data = [[Double]]()
    private var xVector = [Double]()
    private var yVector = [Double]()
    
    public init(x: Double, data: [[Double]]) {
        self.x = x
        self.count = data.count
        self.data = try! data
            .map ({
                guard $0.count == 2 else {
                    throw Error.ArgumentError(msg: "Mismatch in the number of x and y in the dataset.")
                }
                
                xVector.append($0[0])
                yVector.append($0[1])
                
                return $0
            })
    }
    
    private func square(v: Double) -> Double {
        return v * v
    }
    
    /// Sum of the vector values
    private func sum(vector: [Double]) -> Double {
        return vector
            .reduce(0, combine: +)
    }
    
    /// Sum of the vector squared values
    private func sumSquared(vector: [Double]) -> Double {
        return vector
            .map({
                square($0)
            })
            .reduce(0, combine: +)
    }
    
    /// Sum of the product of x and y
    private func sumXY(data: [[Double]]) -> Double {
        return data
            .map({
                $0[0] * $0[1]
            })
            .reduce(0, combine: +)
    }
    
    /// The dispersion
    /// Dv = (Σv² / N) - (Σv / N)²
    private func dispersion(v: String) -> Double {
        let sumSquared = [
            "x": { self.sumSquared(self.xVector) },
            "y": { self.sumSquared(self.yVector) }
        ]
        let sum = [
            "x": { self.sum(self.xVector) },
            "y": { self.sum(self.yVector) }
        ]
        
        return (sumSquared[v]!() / Double(count)) -
            square(sum[v]!() / Double(count))
    }
    
    /// The intercept
    /// a = (ΣY - b(ΣX)) / N
    private func aIntercept(b: Double) -> Double {
        return (sum(yVector) / Double(count)) -
            (b * (sum(xVector) / Double(count)))
    }
    
    /// The slope, or the regression coefficient
    /// b = ((ΣXY / N) - (ΣX / N)(ΣY / N)) / (Σv² / N) - (Σv / N)²
    private func bSlope() -> Double {
        return ((sumXY(data) / Double(count)) -
            ((sum(xVector) / Double(count)) *
            (sum(yVector) / Double(count)))) /
            dispersion("x")
    }
    
    /// The Pearson's correlation coefficient
    /// Rxy = b * (√Dx / √Dy)
    private func corCoefficient(b: Double) -> Double {
        return b * (sqrt(dispersion("x")) / sqrt(dispersion("y")))
    }
    
    /// Creats a linear model that fits the data.
    /// The resulting equation has the form: h(x) = a + bx
    private func createModel(a: Double, _ b: Double) -> (x: Double)->Double {
        return { (x: Double)->Double in
            return a + b*x
        }
    }
    
    private func round_(number: Double) -> Double {
        return round(100000 * number) / 100000
    }
    
    public struct Result {
        public let ln_model: String
        public let cor: Double
        public let x: Double
        public let y: Double
    }
    
    /// Builds the prediction of the expected value of y with the given x, based on linear regression model.
    public func build() throws -> Result {
        // Check the number of observations in a given dataset
        guard count >= 3 else {
            throw Error.ArgumentError(msg: "The dataset should contain a minimum of 3 observations.")
        }
        
        let b = round_(bSlope())
        let a = round_(aIntercept(b))
        let model = createModel(a, b)
        let y = round_(model(x: x))
        
        return Result(
            ln_model: "\(a) + \(b)x",
            cor: round_(corCoefficient(b)),
            x: x,
            y: y
        )
    }
}
