//
//  ChartDataViewModel.swift
//  CandleStick
//
//  Created by Maksym Leshchenko on 10.08.2020.
//  Copyright © 2020 Micro-B. All rights reserved.
//

import Foundation

class ChartDataViewModel {
    
    // MARK: - Properties
    private var provider = GeneralProvider().stubProvider
    private var calculator = PerformanceCalculator()
    private var screen: ChartDataType
    
    var title: String? {
        return screen.title
    }
    
    init(screen: ChartDataType) {
        self.screen = screen
    }
    
    // MARK: - Networking
    func fetchQuotes(successCompletion: @escaping QuotedSymbolsComletion, errorCompletion: @escaping ErrorCompletion) {
        
        switch screen {
        case .daily:
            provider.request(.quotesMonth) { (result) in
                switch result {
                case .success(let response):
                    guard let quotedSymbolsResponse = try? response.map(QuoteSymbolsResponseResponse.self) else {
                        let message = Constants.Strings.Errors.quotesWeekNotFetched
                        errorCompletion(message)
                        return
                    }
                    
                    successCompletion(quotedSymbolsResponse.quoteSymbols)
                case .failure(let error):
                    errorCompletion(error.localizedDescription)
                }
            }
        case .hourly:
            provider.request(.quotesWeek) { (result) in
                switch result {
                case .success(let response):
                    guard let quotedSymbolsResponse = try? response.map(QuoteSymbolsResponseResponse.self) else {
                        let message = Constants.Strings.Errors.quotesWeekNotFetched
                        errorCompletion(message)
                        return
                    }
                    
                    successCompletion(quotedSymbolsResponse.quoteSymbols)
                case .failure(let error):
                    errorCompletion(error.localizedDescription)
                }
            }
        }
    }
}
