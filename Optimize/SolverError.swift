import Foundation

public enum SolverError: ErrorType {
    case MaxIterationsReached(results: SolverResults)
    case FunctionChangeBelowTolerance(results: SolverResults)
}