//
//  GeneralService.swift
//  CandleStick
//
//  Created by Maksym Leshchenko on 10.08.2020.
//  Copyright © 2020 Micro-B. All rights reserved.
//

import Foundation
import Moya

enum GeneralService {
    case quotesWeek
    case quotesMonth
}

extension GeneralService: TargetType {
    
    var baseURL: URL {
        return Constants.baseURL
    }
    
    var path: String {
        switch self {
        case .quotesWeek:
            return "quotesWeek"
        case .quotesMonth:
            return "quotesMonth"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        // MARK: - GET
        default:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        switch self {
        case .quotesWeek:
            do {
                let responseQuotesWeekData = try JsonFileReader().readFile(name: "responseQuotesWeek", type: "json")
                return responseQuotesWeekData
            } catch let fileReaderError as FileReaderError {
                print(fileReaderError.localizedDescription)
            } catch {
                print(error.localizedDescription)
            }
            
            return Data()
                        
        case .quotesMonth:
            do {
                let responseQuotesWeekData = try JsonFileReader().readFile(name: "responseQuotesMonth", type: "json")
                return responseQuotesWeekData
            } catch let fileReaderError as FileReaderError {
                print(fileReaderError.localizedDescription)
            } catch {
                print(error.localizedDescription)
            }
            
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
}
