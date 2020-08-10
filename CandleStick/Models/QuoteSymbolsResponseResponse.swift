//
//  QuoteSymbolsResponseResponse.swift
//  CandleStick
//
//  Created by Maksym Leshchenko on 10.08.2020.
//  Copyright © 2020 Micro-B. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct QuoteSymbolsResponseResponse: Decodable {
    let quoteSymbols: [QuoteSymbol]
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case content
        case status
    }
    
    enum QuoteSymbolsCodingKeys: String, CodingKey {
        case quoteSymbols
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let quoteSymbolsContainer = try container.nestedContainer(keyedBy: QuoteSymbolsCodingKeys.self, forKey: .content)
        
        status = try container.decode(String.self, forKey: .status)
        quoteSymbols = try quoteSymbolsContainer.decode([QuoteSymbol].self, forKey: .quoteSymbols)
    }
}
