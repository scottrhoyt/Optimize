import Foundation

internal struct SolverValues: SolverResults {
    var result: SolverVar
    var value: Double
    var iterations: Int
    var valueChange: Double
    var gradient: SolverVar
    var lastValue: Double
}