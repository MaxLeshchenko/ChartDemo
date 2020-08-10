//
//  Constants.swift
//  CandleStick
//
//  Created by Maksym Leshchenko on 10.08.2020.
//  Copyright © 2020 Micro-B. All rights reserved.
//

import Foundation

typealias VoidCompletion = () -> Void
typealias QuotedSymbolsComletion = (([QuoteSymbol]) -> Void)
typealias ErrorCompletion = ((_ message: String) -> Void)

struct Constants {
    
    static let baseURL: URL = URL(string: "https://www.google.com/")!
    
    struct Strings {
        
        struct Errors {
            static let quotesWeekNotFetched = "Cannot fetch quotes week. Please try update again."
            static let quotesMonthNotFetched = "Cannot fetch quotes month. Please try update again."
        }
        
    }
}
