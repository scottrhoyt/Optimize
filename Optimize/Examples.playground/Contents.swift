//: Playground - noun: a place where people can play

import Foundation
import XCPlayground
import Optimize

func f(x: Double) -> Double {
    return 0.25 * pow(x, 4) - pow(x, 3) + pow(x, 2) - 1
    //return exp(x)
}

func dfdx(x: Double) -> Double {
    return 2*pow(x,3) - 15*pow(x,2) + 2*x - 4
}

let length = 300
let cosine = (0..<length).map({ f(Double($0)/Double(100)) })
for num in cosine {
    XCPCaptureValue("cos", value: num)
}

var solver: Solver = NewtonSolver()
//solver.deriv = dfdx
do {
    //    let results = try solver.solve(10, f: finiteDifference(f, increment: 0.0000001)/*, gradient: dfdx*/)
    let results = try solver.solve(10, f: f/*, gradient: dfdx*/)
    let results2 = try solver.minMax(10, f: f)
    results.result
    results.value
    results.iterations
}
catch SolverError.MaxIterationsReached(let results) {
    print("Max Iter Reached")
    results.result
    results.value
    results.iterations
}
catch SolverError.FunctionChangeBelowTolerance(let results) {
    print("Function Change Below Tolerance")
    results.result
    results.value
    results.iterations
}

//Solver.solve(solver)

//public struct NewtonSolver2: Solver {
//    public var increment = 0.0000001
//    public var maxIter = 100
//    public var tolerance: Double
//    public var limitTolerance: Double
//
//    public init() {
//        tolerance = increment
//        limitTolerance = tolerance
//    }
//
//    public func genNextX(x: SolverVar, value: Double, gradient: SolverVar) -> SolverVar {
//        return x * gradient
//    }
//}
//
//let mySolver2 = NewtonSolver2()
//do {
//    let results = try mySolver2.solve(10, f: f/*, gradient: dfdx*/)
//    results.result
//    results.value
//    results.iterations
//}
//catch SolverError.MaxIterationsReached(let results) {
//    print("Max Iter Reached")
//    results.result
//    results.value
//    results.iterations
//}
//catch SolverError.FunctionChangeBelowTolerance(let results) {
//    print("Function Change Below Tolerance")
//    results.result
//    results.value
//    results.iterations
//}

//func minMax(guess: Double, f:((Double)->Double))-> Double {
//    let newFunc = {
//        (x: Double) -> Double in
//        let increment = 0.00001
//        let fx0 = f(x)
//        let fx1 = f(x+increment)
//        return (fx1 - fx0) / increment
//    }
//    return solve(guess, f: newFunc)
//}
//
//minMax(170, f: f)

//var a = [1, 2, 3]
//var b = a
//a[1] = 42
//a
//b
//
//var c = [1, 2, 3]
//var d = c
//c.append(42)
//c
//d
//
//var e = [1, 2, 3]
//var f = e
//e[0..<2] = [4, 5]
//e
//f
