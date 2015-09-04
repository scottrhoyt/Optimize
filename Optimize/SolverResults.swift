import Foundation

public protocol SolverResults {
    var result: SolverVar { get }
    var value: SolverUnit { get }
    var iterations: Int { get }
}