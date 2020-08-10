//
//  Quotes.swift
//  CandleStick
//
//  Created by Maksym Leshchenko on 10.08.2020.
//  Copyright © 2020 Micro-B. All rights reserved.
//

import Foundation

// MARK: - QuoteSymbol
struct QuoteSymbol: Codable {
    let symbol: String
    let timestamps: [Int]
    let opens, closures, highs, lows: [Double]
    let volumes: [Int]
}
