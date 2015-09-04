//
//  TestFuncs.swift
//  Optimize
//
//  Created by Scott Hoyt on 9/4/15.
//  Copyright © 2015 Scott Hoyt. All rights reserved.
//

import Foundation
import Surge

//public func curve(x: Double, coeff: [Double]) -> Double {
//    let a = coeff[0]
//    let b = coeff[1]
//    let c = coeff[2]
//    let d = coeff[3]
//    let y = a * pow(x, 3) + b * pow(x, 2) + c * x + d
//    return y
//}
//
//var dataPoints: [(Double, Double)] = [
//    (-10, 104),
//    (-5, 141.5),
//    (0, 4),
//    (5, 66.5),
//    (10, 704)
//]
//
//public func error(coeff: [Double]) -> Double {
//    var errors = [Double]()
//    for (x, y) in dataPoints {
//        let value = curve(x, coeff: coeff)
//        let error = value - y
//        errors.append(error)
//    }
//    let totalError = sum(sq(errors))
//    return totalError
//}

public func curve(x: Double, coeff: [Double]) -> Double {
    let a = coeff[0]
    let b = coeff[1]
    let c = coeff[2]
    let y = a * pow(x, 2) + b * x + c
    return y
}

var dataPoints: [(Double, Double)] = [
    (1, 1),
    (2, 1),
    (3, 3),
    (4, 5)
]

public func error(coeff: [Double]) -> Double {
    var errors = [Double]()
    for (x, y) in dataPoints {
        let value = curve(x, coeff: coeff)
        let error = value - y
        errors.append(error)
    }
    let totalError = sum(sq(errors))
    return totalError
}