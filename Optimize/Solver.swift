import Foundation

public typealias SolverVar = Double
public typealias SolverFunc = (SolverVar) -> SolverVar

public func finiteDifference(f: SolverFunc, increment: Double) -> SolverFunc {
    let approx = {
        (x: SolverVar) -> SolverVar in
        return (f(x+increment) - f(x))/increment
    }
    return approx
}

public protocol Solver {
    var increment: Double { get set }
    var maxIter: Int { get set }
    var tolerance: Double { get set }
    var limitTolerance: Double { get set }
    
    func solve(guess: SolverVar, f: SolverFunc, gradient: SolverFunc?) throws -> SolverResults
    func minMax(guess: SolverVar, f: SolverFunc, gradient: SolverFunc?, gradient2: SolverFunc?) throws -> SolverResults
    
    func genNextX(x: SolverVar, value: Double, gradient: Double) -> SolverVar
}

public extension Solver {
    
    public func minMax(guess: SolverVar, f: SolverFunc, gradient: SolverFunc? = nil, gradient2: SolverFunc? = nil) throws -> SolverResults {
        
        let deriv = gradient != nil ? gradient! : finiteDifference(f, increment: increment)
        return try solve(guess, f: deriv, gradient: gradient2)
        
    }
    
    public func solve(guess: SolverVar, f: SolverFunc, gradient: SolverFunc? = nil) throws -> SolverResults {
        
        let deriv = gradient != nil ? gradient! : finiteDifference(f, increment: increment)
        
        var values = SolverValues(result: guess, value: 0, iterations: 0,  valueChange: 0, gradient: guess, lastValue: 0)
        
        repeat {
            values.result = values.iterations == 0 ? guess : genNextX(values.result, value: values.value, gradient: values.gradient)
            values.value = f(values.result)
            values.valueChange = values.iterations == 0 ? Double.infinity : abs(values.value - values.lastValue)
            values.gradient = deriv(values.result)
            log(values)
            values.lastValue = values.value
            values.iterations++
        } while try checkConditions(values)
        
        return values
    }
    
    internal func log(values: SolverValues) {
        print("Iter:\t\(values.iterations)\tx:\t\(values.result)\tvalue:\t\(values.value)\tgradient:\t\(values.gradient)")
    }
    
    internal func checkConditions(values: SolverValues) throws -> Bool {
        try checkForError(values)
        return abs(values.value) > tolerance
    }
    
    internal func checkForError(values: SolverValues) throws {
        if values.iterations == maxIter {
            throw SolverError.MaxIterationsReached(results: values)
        }
        else if values.valueChange <= limitTolerance {
            throw SolverError.FunctionChangeBelowTolerance(results: values)
        }
    }
}