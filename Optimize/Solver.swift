import Foundation
import Surge

public typealias SolverUnit = Double
public typealias SolverVar = Array<SolverUnit>
public typealias SolverFunc = (SolverVar) -> SolverUnit
public typealias GradientFunc = (SolverVar) -> SolverVar

//public func finiteDifference(f: SolverFunc, increment: Double) -> SolverFunc {
//    let approx = {
//        (x: SolverVar) -> SolverVar in
//        return (f(x+increment) + (f(x) * -1))/increment
//    }
//    return approx
//}

public func finiteDifference(f: SolverFunc, increment: Double) -> GradientFunc {
    let approx = {
        (x: SolverVar) -> SolverVar in
        let fx = f(x)
        var gradientVector = SolverVar(count: x.count, repeatedValue: 0)
        for var i = 0; i < x.count; i++ {
            var incrementVector = SolverVar(count: x.count, repeatedValue: 0)
            incrementVector[i] = increment
            //print(incrementVector)
            gradientVector[i] = (f(x+incrementVector) - fx)/increment
        }
        return gradientVector
    }
    return approx
}


public protocol Solver {
    var increment: SolverUnit { get set }
    var maxIter: Int { get set }
    var tolerance: SolverUnit { get set }
    var limitTolerance: SolverUnit { get set }
    
    func solve(guess: SolverVar, f: SolverFunc, gradient: GradientFunc?) throws -> SolverResults
    func minMax(guess: SolverVar, f: SolverFunc, gradient: GradientFunc?, gradient2: GradientFunc?) throws -> SolverResults
    
    func genNextX(f: SolverFunc, x: SolverVar, value: Double, gradient: SolverVar) -> SolverVar
}

public extension Solver {
    
    public func minMax(guess: SolverVar, f: SolverFunc, gradient: GradientFunc? = nil, gradient2: GradientFunc? = nil) throws -> SolverResults {
        
        let deriv = gradient != nil ? gradient! : finiteDifference(f, increment: increment)
        let derivMagnitude = { (x: SolverVar) -> SolverUnit in magnitude(deriv(x)) }
        return try solve(guess, f: derivMagnitude, gradient: gradient2)
        
    }
    
    public func solve(guess: SolverVar, f: SolverFunc, gradient: GradientFunc? = nil) throws -> SolverResults {
        
        let deriv = gradient != nil ? gradient! : finiteDifference(f, increment: increment)
        
        var values = SolverValues(result: guess, value: 0, iterations: 0,  valueChange: 0, gradient: guess, lastValue: 0)
        
        repeat {
            values.result = values.iterations == 0 ? guess : genNextX(f, x: values.result, value: values.value, gradient: values.gradient)
            values.value = f(values.result)
            values.valueChange = values.iterations == 0 ? SolverUnit.infinity : abs(values.value - values.lastValue)
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