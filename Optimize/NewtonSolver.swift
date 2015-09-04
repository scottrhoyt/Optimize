import Foundation
import Surge

public struct NewtonSolver: Solver {
    public var increment = 0.0000001
    public var maxIter = 500000
    public var tolerance: SolverUnit
    public var limitTolerance: SolverUnit
    
    public init() {
        tolerance = increment
        limitTolerance = tolerance
    }
    
    public func genNextX(x: SolverVar, value: SolverUnit, gradient: SolverVar) -> SolverVar {
        //let gradMag = magnitude(gradient)
        let xMove = gradient * (-0.1 / magnitude(gradient))
        //let xMove = gradient * (-value / magnitude(gradient))
        //let xMove = pow(gradient, -1) * value * -1
        //print("Grad Mag: \(gradMag)\tXMove: \(xMove)")
        return x + xMove
    }
}