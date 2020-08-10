//
//  PPerformanceCalculator.swift
//  CandleStick
//
//  Created by Maksym Leshchenko on 10.08.2020.
//  Copyright © 2020 Micro-B. All rights reserved.
//

import Foundation

class PerformanceCalculator {
    
    typealias PerformanceValue = (timestamp: Int, performance: Double)
    
    func calculate(for quote: QuoteSymbol) -> [PerformanceValue] {
        
        let basePrice = quote.opens.first!
        
        let performance = zip(quote.timestamps, quote.opens).map { (hourlyData) -> PerformanceValue in
            let performanceValue = 100 * hourlyData.1 / basePrice - 100
            return (hourlyData.0, performanceValue)
        }
        
        return performance
    }
    
}
