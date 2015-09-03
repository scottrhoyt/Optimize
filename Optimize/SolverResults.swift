import Foundation

public protocol SolverResults {
    var result: SolverVar { get }
    var value: Double { get }
    var iterations: Int { get }
}