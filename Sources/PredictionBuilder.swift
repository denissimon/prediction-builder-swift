//
// PredictionBuilder.swift
//
// PredictionBuilder - A library for machine learning that builds predictions using a linear regression.
//
// Copyright (c) 2016 - 2017 Denis Simon <denis.v.simon@gmail.com>
//
// Licensed under MIT (https://github.com/denissimon/prediction-builder-swift/blob/master/LICENSE)
//

import Foundation

public enum ArgumentError: Error {
    case general(msg: String)
}

open class PredictionBuilder {
    
    private var x: Double
    private var count: Int
    private var data = [[Double]]()
    private var xVector = [Double]()
    private var yVector = [Double]()
    
    public init(x: Double, data: [[Double]]) {
        self.x = x
        self.count = data.count
        self.data = data
            .map ({
                if $0.count == 2 {
                    xVector.append($0[0])
                    yVector.append($0[1])
                }
                return $0
            })
    }
    
    private func square(v: Double) -> Double {
        return v * v
    }
    
    /**
     Sum of the vector values
     */
    private func sum(vector: [Double]) -> Double {
        return vector
            .reduce(0, +)
    }
    
    /**
     Sum of the vector squared values
     */
    private func sumSquared(vector: [Double]) -> Double {
        return vector
            .map({
                square(v: $0)
            })
            .reduce(0, +)
    }
    
    /**
     Sum of the product of x and y
     */
    private func sumXY(data: [[Double]]) -> Double {
        return data
            .map({
                $0[0] * $0[1]
            })
            .reduce(0, +)
    }
    
    /**
     The dispersion
     Dv = (Σv² / N) - (Σv / N)²
     */
    private func dispersion(v: String) -> Double {
        let sumSquared = [
            "x": { self.sumSquared(vector: self.xVector) },
            "y": { self.sumSquared(vector: self.yVector) }
        ]
        
        let sum = [
            "x": { self.sum(vector: self.xVector) },
            "y": { self.sum(vector: self.yVector) }
        ]
        
        return (sumSquared[v]!() / Double(count)) -
            square(v: sum[v]!() / Double(count))
    }
    
    /**
     The intercept
     a = (ΣY - b(ΣX)) / N
     */
    private func aIntercept(b: Double) -> Double {
        return (sum(vector: yVector) / Double(count)) -
            (b * (sum(vector: xVector) / Double(count)))
    }
    
    /**
     The slope, or the regression coefficient
     b = ((ΣXY / N) - (ΣX / N)(ΣY / N)) / (Σv² / N) - (Σv / N)²
     */
    private func bSlope() -> Double {
        return ((sumXY(data: data) / Double(count)) -
            ((sum(vector: xVector) / Double(count)) *
                (sum(vector: yVector) / Double(count)))) /
            dispersion(v: "x")
    }
    
    /**
     The Pearson's correlation coefficient
     Rxy = b * (√Dx / √Dy)
     */
    private func corCoefficient(b: Double) -> Double {
        return b * (sqrt(dispersion(v: "x")) / sqrt(dispersion(v: "y")))
    }
    
    /**
     Creats a linear model that fits the data.
     The resulting equation has the form: h(x) = a + bx
     */
    private func createModel(a: Double, b: Double) -> (_ x: Double)->Double {
        return { (x: Double)->Double in
            return a + b*x
        }
    }
    
    private func round_(number: Double) -> Double {
        return round(100000 * number) / 100000
    }
    
    public struct Result {
        public let lnModel: String
        public let cor, x, y: Double
        public init(lnModel: String, cor: Double, x: Double, y: Double) {
            self.lnModel = lnModel
            self.cor = cor
            self.x = x
            self.y = y
        }
    }
    
    /**
     Builds a prediction of the expected value of y for a given x, based on a linear regression model.
     */
    open func build() throws -> Result {
        // Check the number of observations
        guard count >= 3 else {
            throw ArgumentError.general(msg: "The dataset should contain a minimum of 3 observations.")
        }
        
        // Check the number of x and y
        guard count == xVector.count else {
            throw ArgumentError.general(msg: "Mismatch in the number of x and y in the dataset.")
        }
        
        let b = round_(number: bSlope())
        let a = round_(number: aIntercept(b: b))
        let model = createModel(a: a, b: b)
        let y = round_(number: model(x))
        
        return Result(
            lnModel: "\(a)+\(b)x",
            cor: round_(number: corCoefficient(b: b)),
            x: x,
            y: y
        )
    }
}
