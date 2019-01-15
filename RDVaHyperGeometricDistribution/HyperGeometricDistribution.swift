//
//  HyperGeometricDistribution.swift
//  RDVaHyperGeometricDistribution
//
//  Created by Rob VanHoorne on 1/7/19.
//  Copyright © 2019 Rob VanHoorne. All rights reserved.
//

import Foundation

class HyperGeometricDistribution {
    var sucessStatesOverObservedSuccesses: [(K: Int, k: Int)] // K over k, N - K over n - K
    var populationSize: Int // N
    var numberOfDraws: Int // n
    
    init() {
        sucessStatesOverObservedSuccesses = []
        populationSize = 0
        numberOfDraws = 0
    }
    
    func binomialCoefficient(_ n: Int, choose k: Int) -> Int {
        var bc = Array(repeating: Array(repeating: 0, count: n + 1), count: n + 1)
        
        for i in 0...n {
            bc[i][0] = 1
            bc[i][i] = 1
        }
        
        if n > 0 {
            for i in 1...n {
                for j in 1..<i {
                    bc[i][j] = bc[i - 1][j - 1] + bc[i - 1][j]
                }
            }
        }
        
        return bc[n][k]
    }
    
    func solve() -> Double {
        let numerator = sucessStatesOverObservedSuccesses
            .map {
                binomialCoefficient($0.K, choose: $0.k)
            }
            .reduce(1, *)
        
        let denomonitor = binomialCoefficient(populationSize, choose: numberOfDraws)

        let probability: Double = Double(numerator) / Double(denomonitor)
        
        return probability
    }
}
