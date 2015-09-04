import Foundation
import Surge

public struct NewtonSolver: Solver {
    public var increment = 0.0000001
    public var maxIter = 100000
    public var tolerance: SolverUnit
    public var limitTolerance: SolverUnit
    
    public init() {
        tolerance = increment
        limitTolerance = tolerance
    }
    
    public func genNextX(f: SolverFunc, x: SolverVar, value: SolverUnit, gradient: SolverVar) -> SolverVar {
        //let gradMag = magnitude(gradient)
        let unitGradient = gradient / magnitude(gradient)
        //let xMove = gradient * (-0.1 / magnitude(gradient))
        //let xMove = gradient * (-value / magnitude(gradient))
        //let xMove = pow(gradient, -1) * value * -1
        //print("Grad Mag: \(gradMag)\tXMove: \(xMove)")
        return lineSearch(f, gradient: unitGradient, x: x, fx: value, epsilon: value)
    }
    
    func lineSearch(f: SolverFunc, gradient: SolverVar, x: SolverVar, fx: SolverUnit, epsilon: Double) -> SolverVar {
        let newX = x + (gradient * -1 * epsilon)
        let newFx = f(newX)
        if newFx < fx {
            return newX
        }
        if newFx - fx < tolerance {
            return x
        }
        
        return lineSearch(f, gradient: gradient, x: x, fx: fx, epsilon: epsilon / Double(2))
    }
}