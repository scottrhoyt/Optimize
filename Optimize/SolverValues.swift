import Foundation

internal struct SolverValues: SolverResults {
    var result: SolverVar
    var value: SolverUnit
    var iterations: Int
    var valueChange: SolverUnit
    var gradient: SolverVar
    var lastValue: SolverUnit
}