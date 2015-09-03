import Foundation

public struct NewtonSolver: Solver {
    public var increment = 0.0000001
    public var maxIter = 100
    public var tolerance: Double
    public var limitTolerance: Double
    
    public init() {
        tolerance = increment
        limitTolerance = tolerance
    }
    
    public func genNextX(x: SolverVar, value: Double, gradient: SolverVar) -> SolverVar {
        let xMove = -value / gradient
        return x + xMove
    }
}